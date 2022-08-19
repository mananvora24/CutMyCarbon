import 'package:cut_my_carbon/core/utilities/constants.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: Center(
              child: Column(children: [
                SizedBox(
                  height: height * 0.06,
                  width: width * 0.8,
                  child: const Text('Congratulations! Your saved carbon is: ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: primaryFont,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                ),
                SizedBox(
                  height: height * 0.06,
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
                            return const Text('Error',
                                style: TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                ));
                          } else if (snapshot.hasData) {
                            return Text(snapshot.data!.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0));
                          } else {
                            return const Text('Empty data',
                                style: TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                ));
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}',
                              style: const TextStyle(
                                fontFamily: primaryFont,
                                color: primaryColor,
                              ));
                        }
                      }),
                ),
                SizedBox(
                  height: height * 0.06,
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
                            return const Text('Error',
                                style: TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                ));
                          } else if (snapshot.hasData) {
                            return Text(snapshot.data!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0));
                          } else {
                            return const Text('Empty data',
                                style: TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                ));
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}',
                              style: const TextStyle(
                                fontFamily: primaryFont,
                                color: primaryColor,
                              ));
                        }
                      }),
                ),
                // Save stats data
              ]),
            ),
            persistentFooterButtons: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    model.routeToHomeView();
                  },
                  onLongPress: () {
                    model.routeToHomeView();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    minimumSize: const Size(170, 30),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: primaryFont,
                      color: whiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
