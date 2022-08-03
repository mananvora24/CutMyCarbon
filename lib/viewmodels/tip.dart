class TipsData {
  String category;
  String user;
  int tipOrder;
  String tip;

  TipsData({
    required this.category,
    required this.user,
    required this.tipOrder,
    required this.tip,
  });

  @override
  String toString() {
    return "{category: $category, user: $user, tipOrder: $tipOrder, tip: $tip";
  }
}
