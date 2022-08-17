import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:cut_my_carbon/ui/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            // home: const HomeView(title: "home", user: "user1234"),
            // home: const AuthView(title: "Test"),
            // home: const SignInView(title: 'home'),

            home: const AuthView(
              title: '',
            )
            /*StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Error"));
              } else if (snapshot.hasData) {
                return const HomeView(title: 'title', user: 'user1234');
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              } else {
                return const AuthView(title: 'title');
              }
            },
          ),*/
            ),
      );
}
