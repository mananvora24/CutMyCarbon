// ignore_for_file: file_names

class UserStats {
  String user;
  final num lastWeekCarbon;
  final num lastWeekPossibleCarbon;
  final num totalCarbon;
  final num totalPossibleCarbon;
  final num totalTons;
  final int totalTips;
  final int totalDays;

  UserStats({
    required this.user,
    required this.lastWeekCarbon,
    required this.lastWeekPossibleCarbon,
    required this.totalCarbon,
    required this.totalPossibleCarbon,
    required this.totalTons,
    required this.totalTips,
    required this.totalDays,
  });

  Map<String, dynamic> toJson() => {
        'user': user,
        'lastWeekCarbon': lastWeekCarbon,
        'lastWeekPossibleCarbon': lastWeekPossibleCarbon,
        'totalCarbon': totalCarbon,
        'totalPossibleCarbon': totalPossibleCarbon,
        'totalTons': totalTons,
        'totalTips': totalTips,
        'totalDays': totalDays,
      };

  static UserStats fromJson(Map<String, dynamic> json) => UserStats(
        user: json['user'],
        lastWeekCarbon: json['lastWeekCarbon'],
        lastWeekPossibleCarbon: json['lastWeekPossibleCarbon'],
        totalCarbon: json['totalCarbon'],
        totalPossibleCarbon: json['totalPossibleCarbon'],
        totalTons: json['totalTons'],
        totalTips: json['totalTips'],
        totalDays: json['totalDays'],
      );
}
