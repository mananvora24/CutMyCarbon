import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../Forterra Icon/Ficon.dart';
//import '../models/Tip.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';

//import 'package:flutter/material.dart';
//ddimport 'package:nav_service/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

/*
class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}
*/
/* 
class HomeView extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
));
  }
}
*/
class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Color.fromARGB(255, 119, 188, 63),
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
                  child: Icon(Forterra.logo),
                  backgroundColor: Colors.green,
                  onTap: () {}),
            ],
          ),
          body: Center(
            child: Column(children: [
              Container(
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
                  )),
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
                    fontSize: 40,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(340, 80),
                  padding: EdgeInsets.all(30),
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
                    fontSize: 40,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(340, 80),
                  padding: EdgeInsets.all(30),
                ),
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
