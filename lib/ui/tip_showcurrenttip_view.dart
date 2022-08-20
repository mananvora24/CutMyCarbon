import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TipShowCurrentView extends StatelessWidget {
  const TipShowCurrentView(
      {Key? key,
      required this.category,
      required this.tipOrder,
      required this.tipStartTime})
      : super(key: key);
  final String category;
  final int tipOrder;
  final Timestamp tipStartTime;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String tip = "";
    String tipDescription = "";
    int carbon = 0;
    int dayStart = tipStartTime.toDate().day;
    int today = Timestamp.now().toDate().day;
    int days = 7 - (today - dayStart);

    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: backgroundColor,
            elevation: 0,
            title: Text("Category: $category",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("\nSubmit your progress in $days days",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: primaryFont,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 20.0)),
              SizedBox(
                height: height * 0.1,
                width: width * 0.9,
                child: const Text("\nYou selected:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
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
                          return const Text('Error',
                              style: TextStyle(
                                fontFamily: primaryFont,
                                color: primaryColor,
                              ));
                        } else if (snapshot.hasData) {
                          tip = snapshot.data!['Tip'];
                          tipDescription = snapshot.data!['Description'];
                          carbon = snapshot.data!['Carbon'] as int;
                          return Text(
                              "Tip: $tip\n\nInfo: $tipDescription\n\nCarbon Saving per day: $carbon",
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
              SizedBox(height: height * 0.03),
              Center(
                child: SizedBox(
                  width: width * 0.8,
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
              ),
              SizedBox(
                height: height * 0.15,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
