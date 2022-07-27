import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/tips_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipsView extends StatelessWidget {
  TipsView({Key? key, required this.category}) : super(key: key);
  final String category;
  final Stream<QuerySnapshot> _tipStream =
      FirebaseFirestore.instance.collection('Tips').snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TipsViewModel(),
      child: Consumer<TipsViewModel>(
        builder: (context, model, child) => Scaffold(
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            body: Stack(children: [
              Container(
                height: 600.0,
                width: 600.0,
                margin: const EdgeInsets.symmetric(vertical: 50),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Logo.png'),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 80),
                  child: model.getData(category)
                  /*
                StreamBuilder<QuerySnapshot>(
                  stream: _tipStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        Text tip = const Text("");
                        bool tipFound = false;
                        data.forEach((key, value) {
                          if (data['Category'].toString().compareTo(category) ==
                                  0 &&
                              !tipFound) {
                            print("Category found - tip found");
                            tipFound = true;
                            tip = Text("${data['TipID']} => ${data['Tip']}",
                                textAlign: TextAlign.center,
                                //overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0));
                          } else {
                            print("Category found - no tip found");
                            // tip = const Text("No Tip found");
                          }
                        });
                        return tip;
                      }).toList(),
                    );
                  },
                ),*/
                  ),
            ]),
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
