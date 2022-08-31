import 'package:cut_my_carbon/models/Stats.dart';
import 'package:cut_my_carbon/models/User.dart';
import 'package:cut_my_carbon/viewmodels/tip.dart';
import 'package:flutter/material.dart';

// Common colors used
const primaryColor = Color(0xFF213502);
const secondaryColor = Color(0xFF20525C);
const backgroundColor = Color(0xFFFCFCFA);
const whiteColor = Color(0xFFFCFCFA);

// Common fonts used
const String primaryFont0 = "Poppins-Light";
const String primaryFont = "Poppins-Regular";
const String primaryFont2 = "Poppins-Medium";
const String primaryFont3 = "Poppins-SemiBold";
const String secondaryFont = "";

// User data initialization
const String googleProvider = "google.com";
const String appleProvider = "apple.com";
MyUser user = MyUser("", "");
String currentUserProvider = '';
String currentUserUsername = '';
String currentUserUID = '';
bool currentUserTermsAccepted = false;

// How many tips are there?
List<Map<String, dynamic>> tipCountList = [];

// Supported Categories
const String categoryEnergy = 'Energy';
const String categoryHome = 'Home';
const String categoryFood = 'Food';
const String categoryWater = 'Water';
const String categoryShopping = 'Shopping';
const String categoryTransportation = 'Transportation';

// List to convert month number to string
const months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

// Common font sizes
const double largeButtonFontSize = 30;
const double regularButtonFontSize = 24;
const double appBarFontSize = 25;
const double textTitleFontSize = 25;
const double textNormalFontSize = 20;
const double boxTitleFontSize = 23;
const double boxTextFontSize = 20;

// Initialize tips data
TipsData tipsData = TipsData(
    category: "", user: "", tipOrder: 0, tip: "", description: "", carbon: 0);

// Initialize stats data
UserStats userStats = UserStats(
    user: "",
    lastWeekCarbon: 0,
    lastWeekPossibleCarbon: 0,
    totalCarbon: 0,
    totalPossibleCarbon: 0,
    totalTons: 0);
