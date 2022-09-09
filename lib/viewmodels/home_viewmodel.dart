import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/models/Stats.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:cut_my_carbon/viewmodels/tip.dart';
import 'package:cut_my_carbon/viewmodels/tip_status_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends SharedViewModel {
  HomeViewModel();
  // There is a better way - create a POJO and then instance of POJO
  Map<String, dynamic>? tipData = {};
  String fact = "";
  Map<String, dynamic>? factsData = {};
  String userTip = "";
  String tipDescription = "";

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
    num carbon = 0;
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

  submitTipsData(String user, String category, int tipOrder, int days,
      Timestamp tipStartTime) async {
    num carbon = 0;
    num possibleCarbon = 0;
    int startDays =
        Timestamp.now().toDate().difference(tipStartTime.toDate()).inDays;

    Map<String, dynamic> currentTip =
        await getCurrentTipStatus(user, category, tipOrder);
    print("Submit Tips Data => Save carbon days");
    await saveTipsCarbonDays(
        user, currentTip['Category'], currentTip['TipOrder'], days);
    await saveTipStatusCompleted(category, user, tipOrder);
    carbon = await getTipCarbon(user, category, tipOrder, days, tipStartTime);
    possibleCarbon = carbon * startDays;
    carbon = carbon * days;
    await saveTipResultsInStats(user, carbon, possibleCarbon, days);
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

  Future<num> getTipCarbon(String user, String category, int tipOrder, int days,
      Timestamp tipStartTime) async {
    num carbon = 0;
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
        carbon = tipsData["Carbon"];
        break;
      }
    });

    return carbon;
  }

  Future<void> saveTipResultsInStats(
      String user, num carbon, num possibleCarbon, int days) async {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection('UserStatistics').doc("${user}TipStats");
    db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      num newTotalCarbon;
      num newTotalPossibleCarbon;
      num newTotalTons;
      int newTotalTips;
      int newTotalDays;
      if (snapshot.exists) {
        newTotalCarbon = carbon + (snapshot.get("totalCarbon") ?? 0);
        newTotalPossibleCarbon =
            possibleCarbon + (snapshot.get("totalPossibleCarbon") ?? 0);
        newTotalTips = 1 + (snapshot.get("totalTips") as int);
        newTotalDays = days + (snapshot.get("totalDays") as int);
      } else {
        newTotalCarbon = carbon;
        newTotalPossibleCarbon = possibleCarbon;
        newTotalTips = 1;
        newTotalDays = days;
      }
      newTotalTons = newTotalCarbon / 2000;
      transaction.set(
          docRef,
          {
            'lastWeekCarbon': carbon,
            'lastWeekPossibleCarbon': possibleCarbon,
            'totalCarbon': newTotalCarbon,
            'totalPossibleCarbon': newTotalPossibleCarbon,
            'totalTons': newTotalTons,
            'totalTips': newTotalTips,
            'totalDays': newTotalDays,
            'user': user,
            'userID': currentUserUID,
          },
          SetOptions(merge: true));
    }).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"),
    );
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
    num carbon = 0;
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

  bool isNumeric(String str) {
    try {
      double value = double.parse(str);
    } on FormatException {
      return false;
    } finally {
      // ignore: control_flow_in_finally
      return true;
    }
  }

  bool isInt(String str) {
    try {
      int value = int.parse(str);
    } on FormatException {
      return false;
    } finally {
      // ignore: control_flow_in_finally
      return true;
    }
  }
}
