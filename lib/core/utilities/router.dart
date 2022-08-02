import 'package:cut_my_carbon/ui/about_forterra.dart';
import 'package:cut_my_carbon/ui/about_us.dart';
import 'package:cut_my_carbon/ui/stats_view.dart';
import 'package:cut_my_carbon/ui/tip_selected.dart';
import 'package:cut_my_carbon/ui/tip_status_update.dart';
import 'package:cut_my_carbon/ui/tipcategories_view.dart';
import 'package:flutter/material.dart';
import 'package:cut_my_carbon/ui/home_view.dart';
import 'package:cut_my_carbon/ui/tips_view.dart';
import 'package:cut_my_carbon/ui/inbox_view.dart';
import 'package:cut_my_carbon/core/utilities/route_names.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:cut_my_carbon/ui/auth_view.dart';

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
        return const HomeView(title: "Test");
      case tipsViewRoute:
        var tipCategory = settings.arguments as String;
        return TipsView(category: tipCategory);
      case tipCategoriesViewRoute:
        return const TipCategoriesView(title: "Tip Categories");
      case tipStatusUpdateViewRoute:
        return const TipStatusUpdateView(
          title: "Tip Status Update",
        );
      case tipSelectedViewRoute:
        Map<String, String> tipArgs = settings.arguments as Map<String, String>;
        String tip = tipArgs['tip']!;
        String category = tipArgs['category']!;
        return TipSelectedView(category: category, tip: tip);
      case statsViewRoute:
        return StatsView(title: "Stats");
      case aboutForterraViewRoute:
        return const AboutFView(title: "About Forterra");
      case aboutUsViewRoute:
        return const AboutUsView(title: "About Cut My Carbon");
      case inboxViewRoute:
        return const InboxView(title: "Inbox");
      case authViewRoute:
        return const AuthView(title: "Auth");
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
