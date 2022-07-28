import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class TipsViewModel extends SharedViewModel {
  TipsViewModel();
  int myTipOrder = 1;
  CollectionReference userTips =
      FirebaseFirestore.instance.collection('UsertTips');
  String dataText = "";

  Future<String> getTipForUser(String category, String user) async {
    bool tipFound = false;
    await FirebaseFirestore.instance
        .collection('Tips')
        .where('Category', isEqualTo: category)
        .orderBy('TipOrder')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      for (var snapshot in data) {
        Map<String, dynamic>? tipData = snapshot.data();
        tipData?.forEach((key, value) {
          if (tipData['TipOrder'] > myTipOrder && !tipFound) {
            // Found the tip needed
            tipFound = true;
            dataText = "${tipData['TipOrder']} => ${tipData['Tip']}";
          }
        });
      }
    });
    return dataText;
  }

  int getMyTipOrder() {
    return myTipOrder;
  }
}
