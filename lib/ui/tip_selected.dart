import 'package:cut_my_carbon/viewmodels/tip_selected_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipSelectedView extends StatelessWidget {
  const TipSelectedView({Key? key, required this.category, required this.tip})
      : super(key: key);
  final String category;
  final String tip;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("Creating Selected View - category = $category, tip = $tip");

    return ChangeNotifierProvider(
      create: (context) => TipSelectedViewModel(),
      child: Consumer<TipSelectedViewModel>(
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
                child: const Text("Thank you. You selected: ",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
              ),
              SizedBox(
                width: width * 0.9,
                child: Text(tip,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25.0)),
              ),
              SizedBox(height: height * 0.04),
              Image.asset(
                'assets/Logo.png',
              ),
              SizedBox(height: height * 0.06),
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
                                  fontWeight: FontWeight.bold, fontSize: 25.0));
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    }),
              ),
              SizedBox(height: height * 0.07),
            ]),
            persistentFooterButtons: [
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () {
                  model.routeToHomeView();
                },
                onLongPress: () {
                  model.routeToHomeView();
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
