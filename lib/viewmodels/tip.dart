class TipsData {
  String category;
  String user;
  int tipOrder;
  String tip;
  String description;
  num carbon;

  TipsData({
    required this.category,
    required this.user,
    required this.tipOrder,
    required this.tip,
    required this.description,
    required this.carbon,
  });

  @override
  String toString() {
    return "{category: $category, user: $user, tipOrder: $tipOrder, tip: $tip, description: $description, carbon: $carbon}";
  }
}
