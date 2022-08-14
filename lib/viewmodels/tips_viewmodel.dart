import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:cut_my_carbon/viewmodels/tip.dart';

class TipsViewModel extends SharedViewModel {
  TipsViewModel();
  int myTipOrder = 0;

  String userTip = "";
  Map<String, dynamic>? tipData = {};

  Future<int> getUserCategoryTipOrder(String category, String user) async {
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
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

  Future<void> saveSelectedTip(
      String user, String category, int tipOrder, DateTime startTime) async {
    print("User Tips Document key: $user$category$tipOrder");
    await FirebaseFirestore.instance
        .collection('UserTips')
        .doc("$user$category$tipOrder")
        .set({
          'Category': category,
          'User': user,
          'TipOrder': tipOrder,
          'Days': 0,
          'Start': startTime,
          'End': startTime
        }, SetOptions(merge: true))
        .then((value) => print(
            "UserTips Updated with values: Category=>$category, User=>$user, TipOrder=>$tipOrder, Days: 0, Week: 0"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> saveTipStatusSelected(
      String category, String user, int tipOrder, DateTime startTime) async {
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
        .doc("$user" "TipCheck")
        .set({
          'Category': category,
          'Selected': true,
          'User': user,
          'Completed': false,
          'TipOrder': tipOrder,
          'TipStartTime': startTime
        }, SetOptions(merge: true))
        .then((value) => print("UserTipStatus Updated"))
        .catchError(
            (error) => print("Failed to update user tip status: $error"));
  }

  Future<void> selectTip(String user, String category, int tipOrder) async {
    DateTime startTime = DateTime.now();
    await saveSelectedTip(user, category, tipOrder, startTime);
    await saveTipStatusSelected(category, user, tipOrder, startTime);
  }

  Future<TipsData> getTipForUser(
      String category, String user, int skipCount) async {
    bool tipFound = false;
    int tipOrder = await getUserCategoryTipOrder(category, user) + skipCount;
    print("getTipForUser tipOrder: $tipOrder");
    await FirebaseFirestore.instance
        .collection('Tips')
        .where('Category', isEqualTo: category)
        //.where('TipOrder', isGreaterThan: tipOrder)
        .orderBy('TipOrder')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      print("getTipForUser snapshot list: $data");
      int myTipOrder = tipOrder;
      if (myTipOrder >= data.length) {
        myTipOrder = 0;
      }
      for (var snapshot in data) {
        Map<String, dynamic>? tipData = snapshot.data();
        print("getTipForUser tipData: $tipData");
        //tipData?.forEach((key, value) {
        if (tipData!['TipOrder'] > myTipOrder && !tipFound) {
          // Found the tip needed
          tipFound = true;
          userTip = "${tipData['Tip']}";
          tipOrder = int.parse("${tipData['TipOrder']}");
          break;
        }
        //});
      }
    });
    TipsData tipsData = TipsData(
        category: category, user: user, tipOrder: tipOrder, tip: userTip);

    return tipsData;
  }

  int getMyTipOrder() {
    return myTipOrder;
  }
}
