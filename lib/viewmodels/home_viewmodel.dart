import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class HomeViewModel extends SharedViewModel {
  HomeViewModel();
  // This is a hacky way to do.
  // There is a better way - create a POJO and then instance of POJO
  Map<String, dynamic>? tipData = {};
  String tipCategory = "";
  int tipOrder = 0;

  Future<bool> checkTipStatus(String user) async {
    bool tipSelected = false;
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
        tipData?.forEach((key, value) {
          tipSelected = tipData!['Selected'];
          tipCategory = tipData!['Category'];
          tipOrder = tipData!['TipOrder'];
        });
      }
    });
    return tipSelected;
  }

  Future<Map<String, dynamic>> getCurrentTip(String user) async {
    List<dynamic> dataList = List.empty();
    Map<String, dynamic> currentTip = {};
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
        .where('User', isEqualTo: user)
        .where('Category', isEqualTo: tipCategory)
        .where('TipOrder', isEqualTo: tipOrder)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      dataList = querySnapshot.docs;
      if (dataList.isEmpty) {
        print("Data is empty");
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

  submitTipsData(String user, int days) async {
    Map<String, dynamic> currentTip = await getCurrentTip(user);
    await saveTipsCarbonDays(
        user, currentTip['Category'], currentTip['TipOrder'], days, 25);
  }

  Future<String> getTipsButtonText() async {
    if (await checkTipStatus('user1234')) {
      return 'Submit Your Tip Update';
    }
    return 'Select Your Tip';
  }
}
