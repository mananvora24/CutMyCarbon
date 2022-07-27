import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:flutter/material.dart';

class TipsViewModel extends SharedViewModel {
  TipsViewModel();

  final Stream<QuerySnapshot> _tipStream =
      FirebaseFirestore.instance.collection('Tips').snapshots();
  int myTipID = 0;

  StreamBuilder<QuerySnapshot<Object?>> getData(String category) {
    /*
    print("Called getData with category = $category");
    final databaseReference = FirebaseDatabase.instance.ref("/Tips");
    return databaseReference.once();
    */
    StreamBuilder<QuerySnapshot> queryStreamBuilder =
        StreamBuilder<QuerySnapshot>(
      stream: _tipStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        bool tipFound = false;
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Text tip = const Text("");
            data.forEach((key, value) {
              if (data['Category'].toString().compareTo(category) == 0 &&
                  !tipFound) {
                print("Category found - tip found");
                tipFound = true;
                myTipID = data['TipID'];
                tip = Text("${data['TipID']} => ${data['Tip']}",
                    textAlign: TextAlign.center,
                    //overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25.0));
              } else {
                print("Category found - no tip found");
                // tip = const Text("No Tip found");
              }
            });
            return tip;
          }).toList(),
        );
      },
    );
    //if (queryStreamBuilder.initialData!.docs.isNotEmpty) {
    //  return queryStreamBuilder.initialData!.docs;
    //}
    return queryStreamBuilder;
  }

  int getMyTipID() {
    return myTipID;
  }
}
