import 'package:cloud_firestore/cloud_firestore.dart';

class TipStatusData {
  String category;
  String user;
  int tipOrder;
  bool tipSelected;
  bool tipCompleted;
  Timestamp tipStartTime;

  TipStatusData(
      {required this.category,
      required this.user,
      required this.tipOrder,
      required this.tipSelected,
      required this.tipCompleted,
      required this.tipStartTime});
}
