import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Tip {
  Bool allowUnits;
  final double carbon;
  final String category;
  final String tip;

  Tip({
    required this.allowUnits,
    required this.carbon,
    required this.category,
    required this.tip,
  });

  Map<String, dynamic> toJson() => {
        'allowUnits': allowUnits,
        'carbon': carbon,
        'category': category,
        'tip': tip,
      };

  static Tip fromJson(Map<String, dynamic> json) => Tip(
        allowUnits: json['allowUnits'],
        carbon: json['carbon'],
        category: json['category'],
        tip: json['tip'],
      );
}
