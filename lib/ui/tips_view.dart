import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../Forterra Icon/Ficon.dart';
import '../models/Tip.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';

class TipsView extends StatefulWidget {
  @override
  _TipState createState() => _TipState();
}

class _TipState extends State<TipsView> {
  final Stream<QuerySnapshot> _tipStream =
      FirebaseFirestore.instance.collection('Tips').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 119, 188, 63),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tipStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
    );
  }
}
