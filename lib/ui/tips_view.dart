import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/tips_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../Forterra Icon/Ficon.dart';

class TipsView extends StatelessWidget {
  TipsView({Key? key, required this.title}) : super(key: key);
  final String title;
  final Stream<QuerySnapshot> _tipStream =
      FirebaseFirestore.instance.collection('Tips').snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TipsViewModel(),
      child: Consumer<TipsViewModel>(
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
                    child: const Icon(Icons.info_rounded),
                    backgroundColor: Colors.green,
                    onTap: () {
                      model.routeToAboutUSView();
                    }),
                SpeedDialChild(
                    child: const Icon(Forterra.logo),
                    backgroundColor: Colors.green,
                    onTap: () {
                      model.routeToAboutForterraView();
                    }),
              ],
            ),
            body: //Center(
                //child: Column(children: [
                StreamBuilder<QuerySnapshot>(
              stream: _tipStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['Category']),
                      subtitle: Text(data['Tip']),
                    );
                  }).toList(),
                );
              },
            ),
            persistentFooterButtons: [
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  model.routeToHomeView();
                },
                onLongPress: () {
                  model.routeToHomeView();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  model.routeToStatsView();
                },
                onLongPress: () {
                  model.routeToStatsView();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Stats',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
