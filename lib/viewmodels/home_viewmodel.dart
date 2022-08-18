import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:cut_my_carbon/viewmodels/tip_status_data.dart';

class HomeViewModel extends SharedViewModel {
  HomeViewModel();
  // This is a hacky way to do.
  // There is a better way - create a POJO and then instance of POJO
  Map<String, dynamic>? tipData = {};
  String fact = "";
  Map<String, dynamic>? factsData = {};

  Future<Map<String, dynamic>> getCurrentTip(
      String category, int tipOrder) async {
    List<dynamic> dataList = List.empty();
    Map<String, dynamic> currentTip = {};
    await FirebaseFirestore.instance
        .collection('Tips')
        .where('Category', isEqualTo: category)
        .where('TipOrder', isEqualTo: tipOrder)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      dataList = querySnapshot.docs;
      if (dataList.isEmpty) {
        print("getCurrentTip: Data is empty");
      } else {
        print("getCurrentTip: Data Found");
      }
      for (var snapshot in dataList) {
        currentTip = snapshot.data();
        break;
      }
    });
    return currentTip;
  }

  Future<TipStatusData> checkTipStatus(String user) async {
    TipStatusData tipStatusData = TipStatusData(
        category: "",
        user: "",
        tipOrder: 0,
        tipSelected: false,
        tipCompleted: false,
        tipStartTime: Timestamp.now());
    // Read UserTipStatus to get Tip Status Data
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
        .where('User', isEqualTo: user)
        .where('Completed', isEqualTo: false)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      for (var snapshot in data) {
        tipData = snapshot.data();
        print("Check Tip Status => Found Data => tipData: $tipData");
        tipStatusData = TipStatusData(
            category: tipData!['Category'],
            user: tipData!['User'],
            tipOrder: tipData!['TipOrder'],
            tipSelected: tipData!['Selected'],
            tipCompleted: tipData!['Completed'],
            tipStartTime: tipData!['TipStartTime']);
      }
    });

    return tipStatusData;
  }

  Future<Map<String, dynamic>> getCurrentTipStatus(
      String user, String category, int tipOrder) async {
    List<dynamic> dataList = List.empty();
    Map<String, dynamic> currentTip = {};
    // print("getCurrentTipStatus - Before Query: $TipStatusData");
    await FirebaseFirestore.instance
        .collection('UserTips')
        .where('User', isEqualTo: user)
        .where('Category', isEqualTo: category)
        .where('TipOrder', isEqualTo: tipOrder)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      dataList = querySnapshot.docs;
      //if (dataList.isEmpty) {
      // print("getCurrentTipStatus: Data is empty");
      //} else {
      // print("getCurrentTipStatus: Data Found");
      //}
      for (var snapshot in dataList) {
        currentTip = snapshot.data();
        break;
      }
    });
    return currentTip;
  }

  saveTipsCarbonDays(
      String user, String category, int tipOrder, int days, int week) async {
    await FirebaseFirestore.instance
        .collection('UserTips')
        .doc("$user" "$category" "$tipOrder")
        .update({'Days': days, 'End': Timestamp.now()});
  }

  submitTipsData(String user, String category, int tipOrder, int days) async {
    Map<String, dynamic> currentTip =
        await getCurrentTipStatus(user, category, tipOrder);
    print("Submit Tips Data => Save carbon days");
    await saveTipsCarbonDays(
        user, currentTip['Category'], currentTip['TipOrder'], days, 25);
    await saveTipStatusCompleted(category, user, tipOrder);
  }

  String getTipsButtonText(TipStatusData tipStatusData) {
    if (tipStatusData.tipSelected) {
      return 'Submit Your Tip Update';
    }
    return 'Select Your Tip';
  }

  Future<String> getCategoryFact(String category) async {
    await FirebaseFirestore.instance
        .collection('CategoryFacts')
        .where('Category', isEqualTo: category)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      for (var snapshot in data) {
        factsData = snapshot.data();
        factsData?.forEach((key, value) {
          fact = factsData!["Fact"];
        });
      }
    });
    return fact;
  }

  Future<int> getTipCarbon(
      String user, String category, int tipOrder, int days) async {
    int carbon = 0;
    await FirebaseFirestore.instance
        .collection('Tips')
        .where('Category', isEqualTo: category)
        .where('TipOrder', isEqualTo: tipOrder)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      Map<String, dynamic> tipsData;
      for (var snapshot in data) {
        tipsData = snapshot.data();
        carbon = tipsData["Carbon"] * days;
      }
    });

    // Get current Tip Stats and update them
    Map<String, dynamic> statsData = {
      'lastWeekCarbon': 0,
      'lastWeekPossibleCarbon': 0,
      'totalCarbon': 0,
      'totalPossibleCarbon': 0,
      'totalTons': 0,
      'user': user,
      'userID': 0,
    };
    await FirebaseFirestore.instance
        .collection('UserStatistics')
        .where('user', isEqualTo: user)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("User Statistics: Data is empty");
      }
      for (var snapshot in data) {
        statsData = snapshot.data();
      }
    });

    // Set Tip Carbon Stats now
    await FirebaseFirestore.instance
        .collection('UserStatistics')
        .doc("$user" "TipStats")
        .set({
          'lastWeekCarbon': carbon,
          'lastWeekPossibleCarbon': carbon,
          'totalCarbon': carbon + statsData['totalCarbon'],
          'totalPossibleCarbon': carbon + statsData['totalPossibleCarbon'],
          'totalTons': (carbon + statsData['totalPossibleCarbon']) / 1000,
          'user': user,
          'userID': 0,
        }, SetOptions(merge: true))
        .then((value) => print("UserStatistics complete Updated"))
        .catchError(
            (error) => print("Failed to update user tip status: $error"));

    return carbon;
  }

  Future<void> saveTipStatusCompleted(
      String category, String user, int tipOrder) async {
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
        .doc("$user" "TipCheck")
        .set({
          'Category': category,
          'Selected': true,
          'User': user,
          'Completed': true,
          'TipOrder': tipOrder
        }, SetOptions(merge: true))
        .then((value) => print("UserTipStatus complete Updated"))
        .catchError(
            (error) => print("Failed to update user tip status: $error"));
  }
    Future<String> getUsername(String uID) async {
    Map<String, dynamic> currentUser = {};
    String user = '';
    await FirebaseFirestore.instance
        .collection('Users')
        .where('uID', isEqualTo: uID)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("getCurrentUser: Data is empty");
      } else if (data.isNotEmpty) {
        print("getCurrentUser: Data Found");
        for (var snapshot in data) {
          currentUser = snapshot.data();
          user = currentUser['uID'];
          break;
        }
      }
    });
    return user;
  }
}
