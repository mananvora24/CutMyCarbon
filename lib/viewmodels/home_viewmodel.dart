import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel extends SharedViewModel {
  HomeViewModel();
  Map<String, dynamic>? tipData = {};

  Future<bool> checkTipStatus(String user) async {
    bool tipSelected = false;
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
        .where('User', isEqualTo: user)
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
        });
      }
    });
    return tipSelected;
  }

  Future<String> getTipsButtonText() async {
    if (await checkTipStatus('user1234')) {
      return 'Submit Your Tip Update';
    }
    return 'Select Your Tip';
  }

  void routeToTipStatusUpdateView() {}
}
