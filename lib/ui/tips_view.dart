import 'dart:io';

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
            appBar: AppBar(
              /*automaticallyImplyLeading: true,*/
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Color.fromARGB(255, 119, 188, 63),
              elevation: 0,
            ),
            backgroundColor: Color.fromARGB(255, 119, 188, 63),
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
                  return Center(child: CircularProgressIndicator());
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
                onPressed: () {},
                onLongPress: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                onLongPress: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Skip',
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
