import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:cut_my_carbon/viewmodels/tip.dart';

class TipsViewModel extends SharedViewModel {
  TipsViewModel();

  String userTip = "";
  String tipDescription = "";
  int carbon = 0;
  Map<String, dynamic>? tipData = {};

  Future<int> getMaxCategoryTipOrder(String category) async {
    int count = 0;

    if (tipCountList.isEmpty) {
      List<dynamic> dataList = List.empty();
      Map<String, dynamic> tipCountMap = {};

      await FirebaseFirestore.instance
          .collection('TipCounts')
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        dataList = querySnapshot.docs;
        if (dataList.isEmpty) {
          print("getMaxCategoryTipOrder: Data is empty");
        }
        for (var snapshot in dataList) {
          tipCountMap = snapshot.data();
          tipCountList.add(tipCountMap);
        }
      });
    }
    for (var tipCount in tipCountList) {
      if (tipCount['Category'] == category) {
        count = tipCount['Count'] as int;
      } else {
        print("Tip Category - $category not matched");
      }
    }
    return count;
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

//  int getMyTipOrder() {
//    return myTipOrder;
//  }
}
