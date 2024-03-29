import 'package:cut_my_carbon/viewmodels/stats_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class StatsView extends StatelessWidget {
  const StatsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => StatsViewModel(),
      child: Consumer<StatsViewModel>(
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
            title: const Text('Statistics',
                style: TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: appBarFontSize)),
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: FutureBuilder<Map<String, dynamic>>(
                future: model.getUserStatistics(currentUserUsername),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error',
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                          ));
                    } else if (snapshot.hasData) {
                      num lastWeekCarbon =
                          snapshot.data!['lastWeekCarbon'] as num;
                      num lastWeekPossibleCarbon =
                          snapshot.data!['lastWeekPossibleCarbon'] as num;
                      num totalCarbon = snapshot.data!['totalCarbon'] as num;
                      num totalPossibleCarbon =
                          snapshot.data!['totalPossibleCarbon'] as num;
                      num totalTons = snapshot.data!['totalTons'] as num;
                      int totalTips = snapshot.data!['totalTips'] as int;
                      int totalDays = snapshot.data!['totalDays'] as int;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const SizedBox(
                              child: Text("Total Carbon Saved",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: primaryFont,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: textTitleFontSize)),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              child: Text(
                                  "${totalCarbon.toStringAsFixed(1)} lbs",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: primaryFont,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 80.0)),
                            ),
                            SizedBox(height: height * 0.005),
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              padding: const EdgeInsets.all(9.0),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 15),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.8,
                                        child: const Text(
                                          "Carbon Info",
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: boxTitleFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: primaryColor,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.5,
                                        child: const Text("Last Week",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                            "${lastWeekCarbon.toStringAsFixed(1)} lbs",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.5,
                                        child: const Text("Last Week Possible",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                            "${lastWeekPossibleCarbon.toStringAsFixed(1)} lbs",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.5,
                                        child: const Text("Total Pounds",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                            "${totalCarbon.toStringAsFixed(1)} lbs",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.5,
                                        child: const Text("Total Tons",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                            "${totalTons.toStringAsFixed(2)} tons",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.5,
                                        child: const Text("Total Possible",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                            "${totalPossibleCarbon.toStringAsFixed(1)} lbs",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: boxTextFontSize)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              padding: const EdgeInsets.all(9.0),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 15),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.8,
                                        child: const Text(
                                          "Tip Info",
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: textNormalFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: primaryColor,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.4,
                                        child: const Text("Total Tips",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: textNormalFontSize)),
                                      ),
                                      SizedBox(
                                        width: width * 0.4,
                                        child: Text("$totalTips",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: textNormalFontSize)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [],
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.4,
                                        child: const Text("Total Days",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: textNormalFontSize)),
                                      ),
                                      SizedBox(
                                        width: width * 0.4,
                                        child: Text("$totalDays",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: primaryFont,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: textNormalFontSize)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text('Error',
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
      ),
    );
  }
}
