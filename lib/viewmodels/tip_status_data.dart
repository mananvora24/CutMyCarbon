class TipStatusData {
  String category;
  String user;
  int tipOrder;
  bool tipSelected;
  bool tipCompleted;

  TipStatusData(
      {required this.category,
      required this.user,
      required this.tipOrder,
      required this.tipSelected,
      required this.tipCompleted});
}
