import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipSelectedView extends StatelessWidget {
  const TipSelectedView(
      {Key? key, required this.category, required this.tipOrder})
      : super(key: key);
  final String category;
  final int tipOrder;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String tip = "";
    String tipDescription = "";
    print(
        "Creating Selected View - category = $category, tipOrder = $tipOrder");

    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0)),
              backgroundColor: const Color.fromARGB(255, 119, 188, 63),
              elevation: 0,
            ),
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            body: Column(children: [
              SizedBox(height: height * 0.03),
              SizedBox(
                width: width * 0.9,
                child: const Text("You selected: ",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
              ),
              SizedBox(
                width: width * 0.9,
                child: FutureBuilder<Map<String, dynamic>>(
                    future: model.getCurrentTip(category, tipOrder),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          tip = snapshot.data!['Tip'];
                          tipDescription = snapshot.data!['Description'];
                          return Text("Tip: $tip\n\nInfo: $tipDescription",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0));
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    }),
              ),
              SizedBox(height: height * 0.03),
              SizedBox(
                width: width * 0.9,
                child: FutureBuilder<String>(
                    future: model.getCategoryFact(category),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return Text(snapshot.data!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0));
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    }),
              ),
            ]),
            persistentFooterButtons: [
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () {
                  model.routeToHomeView('user1234');
                },
                onLongPress: () {
                  model.routeToHomeView('user1234');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 30),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
