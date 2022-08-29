import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/models/Stats.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:cut_my_carbon/viewmodels/tip.dart';
import 'package:cut_my_carbon/viewmodels/tip_status_data.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends SharedViewModel {
  HomeViewModel();
  // There is a better way - create a POJO and then instance of POJO
  Map<String, dynamic>? tipData = {};
  String fact = "";
  Map<String, dynamic>? factsData = {};
  String userTip = "";
  String tipDescription = "";
  int carbon = 0;

  Future<List<Map<String, dynamic>>?> getTipCount(
      String category, int tipOrder) async {
    List<dynamic> dataList = List.empty();
    List<Map<String, dynamic>> tipCounts = List.empty();
    Map<String, dynamic> tipCountMap = {};
    await FirebaseFirestore.instance
        .collection('TipCounts')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      dataList = querySnapshot.docs;
      if (dataList.isEmpty) {
        print("getTipCount: Data is empty");
      } else {
        print("getTipCount: Data Found");
      }
      for (var snapshot in dataList) {
        tipCountMap = snapshot.data();
        tipCounts.add(tipCountMap);
        break;
      }
    });
    return tipCounts;
  }

  Future<TipsData> getCurrentTip(
      String category, int tipOrder, String user) async {
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
        userTip = currentTip['Tip'];
        tipDescription = currentTip['Description'];
        carbon = currentTip['Carbon'];
        break;
      }
    });
    TipsData tipsData = TipsData(
        category: category,
        user: user,
        tipOrder: tipOrder,
        tip: userTip,
        description: tipDescription,
        carbon: carbon);

    return tipsData;
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
        print("checkTipStatus: Data is empty");
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
      for (var snapshot in dataList) {
        currentTip = snapshot.data();
        break;
      }
    });
    return currentTip;
  }

  saveTipsCarbonDays(
      String user, String category, int tipOrder, int days) async {
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
        user, currentTip['Category'], currentTip['TipOrder'], days);
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
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      int size = data.length;
      int day = int.parse(DateFormat("D").format(Timestamp.now().toDate()));
      int factIndex = day % size;
      fact = data[factIndex]!["Fact"];
    });
    return fact;
  }

  Future<int> getTipCarbon(String user, String category, int tipOrder, int days,
      Timestamp tipStartTime) async {
    int carbon = 0;
    int startDays =
        Timestamp.now().toDate().difference(tipStartTime.toDate()).inDays;
    int possibleCarbon = 0;
    print("Get Tip Carbon Called");
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
        possibleCarbon = tipsData['Carbon'] * startDays;
        break;
      }
    });

    // Get current Tip Stats and update them
    Map<String, dynamic> statsData = {};
    await FirebaseFirestore.instance
        .collection('UserStatistics')
        .where('user', isEqualTo: user)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("User Statistics: Data is empty");
        userStats = UserStats(
            user: user,
            lastWeekCarbon: carbon,
            lastWeekPossibleCarbon: possibleCarbon,
            totalCarbon: carbon,
            totalPossibleCarbon: possibleCarbon,
            totalTons: carbon / 2000);
      } else {
        for (var snapshot in data) {
          statsData = snapshot.data();
          break;
        }
        userStats = UserStats(
            user: user,
            lastWeekCarbon: carbon,
            lastWeekPossibleCarbon: possibleCarbon,
            totalCarbon: carbon + statsData['totalCarbon'] as int,
            totalPossibleCarbon:
                possibleCarbon + statsData['totalPossibleCarbon'] as int,
            totalTons: (carbon + statsData['totalCarbon']) / 2000);
      }
    });

    print("UserStats Data:$userStats");
    // Set Tip Carbon Stats now
    await FirebaseFirestore.instance
        .collection('UserStatistics')
        .doc("$user" "TipStats")
        .set({
          'lastWeekCarbon': userStats.lastWeekCarbon,
          'lastWeekPossibleCarbon': userStats.lastWeekPossibleCarbon,
          'totalCarbon': userStats.totalCarbon,
          'totalPossibleCarbon': userStats.totalPossibleCarbon,
          'totalTons': userStats.totalTons,
          'user': user,
          'userID': currentUserUID,
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

  Future<int> getUserCategoryTipOrder(String category, String user) async {
    int myTipOrder = 0;

    await FirebaseFirestore.instance
        .collection('UserTips')
        .where('User', isEqualTo: user)
        .where('Category', isEqualTo: category)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("getUserCategoryTipOrder: Data is empty");
      } else {
        tipData = data.last.data();
        myTipOrder = tipData!['TipOrder'];
      }
    });
    return myTipOrder;
  }

  Future<TipsData> getTipForUser(
      String category, String user, bool skip, int tipOverride) async {
    bool tipFound = false;
    int tipOrder = 0;
    if (skip) {
      tipOrder = tipOverride;
    } else {
      tipOrder = await getUserCategoryTipOrder(category, user);
    }
    await FirebaseFirestore.instance
        .collection('Tips')
        .where('Category', isEqualTo: category)
        .orderBy('TipOrder')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("getTipForUser: Data is empty");
      }
      int myTipOrder = tipOrder;
      if (myTipOrder >= data.length) {
        myTipOrder = 0;
      }
      for (var snapshot in data) {
        Map<String, dynamic>? tipData = snapshot.data();
        int dataTipOrder = tipData!['TipOrder'] as int;
        print("getTipForUser tipData: $tipData");
        if (dataTipOrder > myTipOrder && !tipFound) {
          // Found the tip needed
          tipFound = true;
          userTip = tipData['Tip'];
          tipOrder = tipData['TipOrder'] as int;
          tipDescription = tipData['Description'];
          carbon = tipData['Carbon'];
          break;
        }
      }
    });
    TipsData tipsData = TipsData(
        category: category,
        user: user,
        tipOrder: tipOrder,
        tip: userTip,
        description: tipDescription,
        carbon: carbon);

    return tipsData;
  }
}
