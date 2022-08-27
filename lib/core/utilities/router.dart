import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/ui/about_forterra.dart';
import 'package:cut_my_carbon/ui/about_us.dart';
import 'package:cut_my_carbon/ui/feedback_thanks_view.dart';
import 'package:cut_my_carbon/ui/help_view.dart';
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
import 'package:cut_my_carbon/ui/settings_view.dart';
import 'package:cut_my_carbon/ui/suggest_a_tip_view.dart';
import 'package:cut_my_carbon/ui/suggest_a_tip_thanks_view.dart';
import 'package:cut_my_carbon/ui/terms_view.dart';
import 'package:cut_my_carbon/ui/accept_terms_view.dart';

/// Class that generates routes for the application
///   - Routes are generated by the list of routes in the app
///   - Routes can also require parameters. e.g. `PostDetailView(post: post)
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
        return const HomeView(title: "Home");
      case tipsViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, dynamic>;
        String user = tipArgs['user']!;
        String tipCategory = tipArgs['category']!;
        bool skip = tipArgs['skip']! as bool;
        int tipOverride = tipArgs['tipOverride']! as int;
        int tipMax = tipArgs['tipMax']! as int;
        return TipsView(
            user: user,
            category: tipCategory,
            skip: skip,
            tipOverride: tipOverride,
            tipMax: tipMax);
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
        Timestamp tipStartTime = tipArgs['tipStartTime'] as Timestamp;
        return TipStatusResultsView(
          user: user,
          category: category,
          tipOrder: tipOrder,
          days: days,
          tipStartTime: tipStartTime,
        );
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
        return const StatsView(title: "Stats");
      case aboutForterraViewRoute:
        return const AboutFView(title: "About Forterra");
      case aboutUsViewRoute:
        return const AboutUsView(title: "About Cut My Carbon");
      case inboxViewRoute:
        return const InboxView();
      case authViewRoute:
        return const AuthView(title: "Auth");
      case feedbackViewRoute:
        return FeedbackView();
      case feedbackThanksViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, String>;
        String reason = tipArgs['reason'];
        String feedback = tipArgs['feedback'];
        String message = tipArgs['message'];
        return FeedbackThanksView(
            reason: reason, feedback: feedback, message: message);
      case suggestATipViewRoute:
        return SuggestATipView(title: "Suggest A Tip");
      case suggestATipThanksViewRoute:
        Map<String, dynamic> tipArgs =
            settings.arguments as Map<String, String>;
        String category = tipArgs['category'];
        String tip = tipArgs['tip'];
        String message = tipArgs['message'];
        return SuggestATipThanksView(
          category: category,
          tip: tip,
          message: message,
        );
      case settingsViewRoute:
        return const SettingsView(title: "Settings");
      case helpViewRoute:
        return const HelpView(title: "Help");
      case termsViewRoute:
        return const TermsView(title: "Terms");

      case acceptTermsViewRoute:
        return const AcceptTermsView(title: "Accept Terms");

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
