import 'package:cut_my_carbon/Forterra%20Icon/Ficon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Forterra Icon/Ficon.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cut_my_carbon/core/utilities/router.dart' as router;
import 'package:cut_my_carbon/ui/home_view.dart';
import 'package:cut_my_carbon/core/services/navigation_service.dart';

import 'locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
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
        //theme: ThemeData(
        //scaffoldBackgroundColor: const Color.fromARGB(255, 49, 48, 48),
        //primarySwatch: Colors.green,
        home: HomeView());
  }
}
