import 'package:cut_my_carbon/Forterra%20Icon/Ficon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final dbRef = FirebaseDatabase.instance.ref();
  final snapshot = await dbRef.child("Tips/TipsTable");

  runApp(MyApp());
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
        title: 'Cut My Carbon',
        //theme: ThemeData(
        //scaffoldBackgroundColor: const Color.fromARGB(255, 49, 48, 48),
        //primarySwatch: Colors.green,
        home: Scaffold(
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.green,
              spacing: 15,
              children: [
                SpeedDialChild(
                    child: Icon(Icons.settings_rounded),
                    backgroundColor: Colors.green,
                    onTap: () {}),
                SpeedDialChild(
                    child: Icon(Icons.mail_rounded),
                    backgroundColor: Colors.green,
                    onTap: () {}),
                SpeedDialChild(
                    child: Icon(Icons.feedback_rounded),
                    backgroundColor: Colors.green,
                    onTap: () {}),
                SpeedDialChild(
                    child: Icon(Icons.tips_and_updates_rounded),
                    backgroundColor: Colors.green,
                    onTap: () {}),
                SpeedDialChild(
                    child: Icon(Icons.info_rounded),
                    backgroundColor: Colors.green,
                    onTap: () {}),
                SpeedDialChild(
                  backgroundColor: Colors.green,
                  child: Text(
                    'F',
                    style: TextStyle(
                      fontFamily: 'Forterra',
                      fontSize: 20,
                    ),
                    /*child: Icon(Forterra.F),
                    backgroundColor: Colors.green,
                    onTap: () {}*/
                  ),
                )
              ],
            ),
            backgroundColor: Color.fromARGB(255, 119, 188, 63),
            body: Center(
                child: Column(children: [
              /*Container(
                  padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'F',
                      style: TextStyle(
                        fontFamily: 'Forterra',
                        fontSize: 20,
                      ),
                    ), //Icon(Icons.letter_, size: 20),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), minimumSize: Size.square(40)),
                  )),*/
              SizedBox(height: 80),
              Container(
                child: Image.asset(
                  'assets/Logo.png',
                ),
              ),
              SizedBox(height: 60),
              Container(
                  child: ElevatedButton(
                onPressed: () {
                  print("Tips Pressed");
                },
                onLongPress: () {
                  print("Tips Long Pressed");
                },
                child: Text(
                  'Select Your Tip',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(248, 60),
                  padding: EdgeInsets.all(15),
                ),
              )),
              SizedBox(height: 30),
              Container(
                  child: ElevatedButton(
                onPressed: () {
                  print("Statistics Pressed");
                },
                onLongPress: () {
                  print("Statistics Long Pressed");
                },
                child: Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(248, 60),
                  padding: EdgeInsets.all(15),
                ),
              ))
            ]))));
  }
}
