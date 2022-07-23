import 'package:cut_my_carbon/Forterra%20Icon/Ficon.dart';
import 'package:cut_my_carbon/ui/tips_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Forterra Icon/Ficon.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cut_my_carbon/core/utilities/router.dart' as router;
import 'package:cut_my_carbon/ui/home_view.dart';
import 'package:cut_my_carbon/core/services/navigation_service.dart';
import 'firebase_options.dart';

import 'locator.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: (settings) =>
          router.Router.generateRoute(context, settings),
      title: 'Cut My Carbon',
      home: const HomeView(title: "Test"),
      // tips: TipsView()
    );
  }
}
