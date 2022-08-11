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

  Future<TipStatusData> checkTipStatus(String user) async {
    TipStatusData tipStatusData = TipStatusData(
        category: "",
        user: "",
        tipOrder: 0,
        tipSelected: false,
        tipCompleted: false);
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
            tipCompleted: tipData!['Completed']);
      }
    });
    return tipStatusData;
  }

  Future<Map<String, dynamic>> getCurrentTip(
      String user, String category, int tipOrder) async {
    List<dynamic> dataList = List.empty();
    Map<String, dynamic> currentTip = {};
    print("getCurrentTip - Before Query: $TipStatusData");
    await FirebaseFirestore.instance
        .collection('UserTips')
        .where('User', isEqualTo: user)
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

  saveTipsCarbonDays(
      String user, String category, int tipOrder, int days, int week) async {
    await FirebaseFirestore.instance
        .collection('UserTips')
        .doc("$user" "$category" "$tipOrder")
        .set({
      'User': user,
      'Category': category,
      'TipOrder': tipOrder,
      'Days': days,
      'Week': week
    });
  }

  submitTipsData(String user, String category, int tipOrder, int days) async {
    Map<String, dynamic> currentTip =
        await getCurrentTip(user, category, tipOrder);
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

  Future<int> getTipCarbon(String category, int tipOrder, int days) async {
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
}
