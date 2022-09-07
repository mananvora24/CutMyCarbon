// ignore_for_file: file_names

class UserStats {
  String user;
  final num lastWeekCarbon;
  final num lastWeekPossibleCarbon;
  final num totalCarbon;
  final num totalPossibleCarbon;
  final num totalTons;
  final int tipCount;
  final int tipDays;

  UserStats({
    required this.user,
    required this.lastWeekCarbon,
    required this.lastWeekPossibleCarbon,
    required this.totalCarbon,
    required this.totalPossibleCarbon,
    required this.totalTons,
    required this.tipCount,
    required this.tipDays,
  });

  Map<String, dynamic> toJson() => {
        'user': user,
        'lastWeekCarbon': lastWeekCarbon,
        'lastWeekPossibleCarbon': lastWeekPossibleCarbon,
        'totalCarbon': totalCarbon,
        'totalPossibleCarbon': totalPossibleCarbon,
        'totalTons': totalTons,
        'tipCount': tipCount,
        'tipDays': tipDays,
      };

  static UserStats fromJson(Map<String, dynamic> json) => UserStats(
        user: json['user'],
        lastWeekCarbon: json['lastWeekCarbon'],
        lastWeekPossibleCarbon: json['lastWeekPossibleCarbon'],
        totalCarbon: json['totalCarbon'],
        totalPossibleCarbon: json['totalPossibleCarbon'],
        totalTons: json['totalTons'],
        tipCount: json['tipCount'],
        tipDays: json['tipDays'],
      );
}
