import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:cut_my_carbon/viewmodels/tip_status_data.dart';

class HomeViewModel extends SharedViewModel {
  HomeViewModel();
  // This is a hacky way to do.
  // There is a better way - create a POJO and then instance of POJO
  Map<String, dynamic>? tipData = {};

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
    // currentTip.forEach((key, value) {});
    await saveTipsCarbonDays(
        user, currentTip['Category'], currentTip['TipOrder'], days, 25);
  }

  String getTipsButtonText(TipStatusData tipStatusData) {
    if (tipStatusData.tipSelected) {
      return 'Submit Your Tip Update';
    }
    return 'Select Your Tip';
  }
}
