import 'package:flutter/material.dart';

import 'ui/home_view.dart';

void main() {
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
            backgroundColor: Color.fromARGB(255, 119, 188, 63),
            body: Center(
                child: Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 40, 10, 0),
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.email, size: 20),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), minimumSize: Size.square(40)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.settings, size: 20),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), minimumSize: Size.square(40)),
                  )),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'F',
                      style: TextStyle(
                        fontFamily: 'Forterra',
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                      ),
                    ), //Icon(Icons.letter_, size: 20),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), minimumSize: Size.square(40)),
                  )),
              Container(
                child: Image.asset(
                  'assets/Logo.png',
                ),
              ),
              Container(
                  child: ElevatedButton(
                onPressed: () {
                  print("Tips Pressed");
                },
                onLongPress: () {
                  print("Tips Long Pressed");
                },
                child: Text('Tips'),
              )),
              SizedBox(height: 20),
              Container(
                  child: TextButton(
                onPressed: () {
                  print("Statistics Pressed");
                },
                onLongPress: () {
                  print("Statistics Long Pressed");
                },
                child: Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 40,
                    backgroundColor: Colors.brown,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 100),
                  padding: EdgeInsets.all(10),
                ),
              ))
            ]))));
  }
}
