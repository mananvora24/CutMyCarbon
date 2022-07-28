import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/stats_viewmodel.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../models/Stat.dart';

class StatsView extends StatelessWidget {
  StatsView({Key? key, required this.title}) : super(key: key);
  final String title;
  final Stream<QuerySnapshot> _statStream =
      FirebaseFirestore.instance.collection('Statistics').snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatsViewModel(),
      child: Consumer<StatsViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            /*automaticallyImplyLeading: true,*/
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            elevation: 0,
          ),
          backgroundColor: const Color.fromARGB(255, 119, 188, 63),
          body: StreamBuilder<QuerySnapshot>(
            stream: _statStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['metric1'].toString()),
                    subtitle: Text(data['metric2'].toString()),
                  );
                }).toList(),
              );
            },
          ),
          persistentFooterButtons: [
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                model.routeToTipCategoriesView();
              },
              onLongPress: () {
                model.routeToTipCategoriesView();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(170, 40),
                padding: const EdgeInsets.all(10),
              ),
              child: const Text(
                'Tips',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
