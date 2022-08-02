import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:cut_my_carbon/ui/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cut_my_carbon/core/utilities/router.dart' as router;
import 'package:cut_my_carbon/ui/auth_view.dart';
import 'package:cut_my_carbon/core/services/navigation_service.dart';
import 'package:provider/provider.dart';
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
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSigninProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigationKey,
          onGenerateRoute: (settings) =>
              router.Router.generateRoute(context, settings),
          title: 'Cut My Carbon',
          // home: const AuthView(title: "Test"),
          home: const HomeView(title: "Test"),
          // tips: TipsView()
        ),
      );
}
