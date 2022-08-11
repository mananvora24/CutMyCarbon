import 'package:flutter/material.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class TipStatusResultsView extends StatelessWidget {
  const TipStatusResultsView({
    Key? key,
    required this.user,
    required this.category,
    required this.tipOrder,
    required this.days,
  }) : super(key: key);
  final String user;
  final String category;
  final int tipOrder;
  final int days;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              backgroundColor: const Color.fromARGB(255, 119, 188, 63),
              elevation: 0,
            ),
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            body: Center(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                  alignment: Alignment.topRight,
                ),
                const Text('Congratulations! Your saved carbon is: ',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                const SizedBox(
                  height: 50,
                ),
                // Get the carbon calculation
                SizedBox(
                  width: width * 0.9,
                  child: FutureBuilder<int>(
                      future:
                          model.getTipCarbon(user, category, tipOrder, days),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<int> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            return Text(snapshot.data!.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0));
                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      }),
                ),
                // Get the fun fact
                SizedBox(
                  width: width * 0.9,
                  child: FutureBuilder<String>(
                      future: model.getCategoryFact(category),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<String> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            return Text(snapshot.data!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0));
                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      }),
                ),
                // Save stats data
              ]),
            ),
            persistentFooterButtons: [
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
