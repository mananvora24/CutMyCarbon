import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/ui/about_forterra.dart';
import 'package:cut_my_carbon/ui/about_us.dart';
import 'package:cut_my_carbon/ui/stats_view.dart';
import 'package:cut_my_carbon/ui/tip_selected.dart';
import 'package:cut_my_carbon/ui/tip_showcurrenttip_view.dart';
import 'package:cut_my_carbon/ui/tip_status_results_view.dart';
import 'package:cut_my_carbon/ui/tip_status_update_view.dart';
import 'package:cut_my_carbon/ui/tipcategories_view.dart';
import 'package:flutter/material.dart';
import 'package:cut_my_carbon/ui/home_view.dart';
import 'package:cut_my_carbon/ui/tips_view.dart';
import 'package:cut_my_carbon/ui/inbox_view.dart';
import 'package:cut_my_carbon/core/utilities/route_names.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:cut_my_carbon/ui/auth_view.dart';
import 'package:cut_my_carbon/ui/signin_view.dart';
import 'package:cut_my_carbon/ui/feedback_view.dart';

/// Class that generates routes for the application
///   - Routes are generated by the list of routes in the app
///   - Routes can also require parameters. e.g. `PostDetailView(post: post)`
///
class Router {
  static String currentScreenName = '';

  static Route<dynamic> generateRoute(
    BuildContext context,
    RouteSettings settings,
  ) {
    return platformPageRoute(
      context: context,
      settings: RouteSettings(name: settings.name),
      builder: (context) => _generateRoute(settings),
      fullscreenDialog: _fullScreenDialogs.contains(settings.name),
    );
  }

  static Widget _generateRoute(RouteSettings settings) {
    String tempSettings = settings.name ?? '';
    routeName(tempSettings);
    switch (settings.name) {
      case homeViewRoute:
        var user = settings.arguments as String;
        return HomeView(title: "Home", user: user);
      case tipsViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, dynamic>;
        String user = tipArgs['user']!;
        String tipCategory = tipArgs['category']!;
        int skipCount = tipArgs['skipCount']! as int;
        return TipsView(
            user: user, category: tipCategory, skipCount: skipCount);
      case tipCategoriesViewRoute:
        var user = settings.arguments as String;
        return TipCategoriesView(user: user);
      case tipStatusUpdateViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, dynamic>;
        String user = tipArgs['user']!;
        String category = tipArgs['category']!;
        int tipOrder = tipArgs['tipOrder']! as int;
        Timestamp tipStartTime = tipArgs['tipStartTime'] as Timestamp;
        String message = tipArgs['message'];
        return TipStatusUpdateView(
            user: user,
            category: category,
            tipOrder: tipOrder,
            tipStartTime: tipStartTime,
            message: message);
      case tipStatusResultsViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, dynamic>;
        String user = tipArgs['user']!;
        String category = tipArgs['category']!;
        int tipOrder = tipArgs['tipOrder']! as int;
        int days = tipArgs['days']! as int;
        return TipStatusResultsView(
            user: user, category: category, tipOrder: tipOrder, days: days);
      case signInViewRoute:
        return const SignInView(
          title: "SignIn",
        );
      case tipSelectedViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, dynamic>;
        String category = tipArgs['category']!;
        int tipOrder = tipArgs['tipOrder']! as int;
        return TipSelectedView(
          category: category,
          tipOrder: tipOrder,
        );
      case tipShowCurrentViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, dynamic>;
        String category = tipArgs['category']!;
        int tipOrder = tipArgs['tipOrder']! as int;
        Timestamp tipStartTime = tipArgs['tipStartTime'] as Timestamp;
        return TipShowCurrentView(
          category: category,
          tipOrder: tipOrder,
          tipStartTime: tipStartTime,
        );
      case statsViewRoute:
        return StatsView(title: "Stats");
      case aboutForterraViewRoute:
        return const AboutFView(title: "About Forterra");
      case aboutUsViewRoute:
        return const AboutUsView(title: "About Cut My Carbon");
      case inboxViewRoute:
        return const InboxView();
      case authViewRoute:
        return const AuthView(title: "Auth");
      case feedbackViewRoute:
        return FeedbackView(title: "Feedback");
      default:
        return Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        );
    }
  }

  static String routeName(String name) {
    currentScreenName = name;
    return name;
  }

  static final _fullScreenDialogs = [
    // Routes.route_1,
    // Routes.route_2,
  ];
}
