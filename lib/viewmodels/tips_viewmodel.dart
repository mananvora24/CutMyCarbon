import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class TipsViewModel extends SharedViewModel {
  TipsViewModel();
  int myTipOrder = 0;
  CollectionReference userTips =
      FirebaseFirestore.instance.collection('UsertTips');
  String userTip = "";
  Map<String, dynamic>? tipData = {};

  Future<int> getUserCategoryTipOrder(String category, String user) async {
    await FirebaseFirestore.instance
        .collection('UserTips')
        .where('User', isEqualTo: user)
        .where('Category', isEqualTo: category)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      for (var snapshot in data) {
        tipData = snapshot.data();
        tipData?.forEach((key, value) {
          myTipOrder = tipData!['TipOrder'];
        });
      }
    });
    return myTipOrder;
  }

  Future<void> saveSelectedTip() async {
    await userTips
        .doc("$tipData['User']$tipData['Category']$tipData['TipOrder']")
        .update(
          {'TipOrder': "$tipData['TipOrder']"},
        )
        .then((value) => print("UserTips Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> saveTipStatus(String category, String user) async {
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
        .doc("$user" "TipCheck")
        .set({'Category': "", 'Selected': false, 'User': user},
            SetOptions(merge: true))
        .then((value) => print("UserTipStatus Updated"))
        .catchError(
            (error) => print("Failed to update user tip status: $error"));
  }

  Future<String> getTipForUser(String category, String user) async {
    bool tipFound = false;
    int tipOrder = await getUserCategoryTipOrder(category, user);
    await FirebaseFirestore.instance
        .collection('Tips')
        .where('Category', isEqualTo: category)
        .where('TipOrder', isGreaterThan: tipOrder)
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
          if (tipData['TipOrder'] > tipOrder && !tipFound) {
            // Found the tip needed
            tipFound = true;
            userTip = "${tipData['TipOrder']} => ${tipData['Tip']}";
          }
        });
        break;
      }
    });
    return userTip;
  }

  int getMyTipOrder() {
    return myTipOrder;
  }
}
