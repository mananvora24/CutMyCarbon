import 'package:cut_my_carbon/viewmodels/stats_viewmodel.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

//import '../models/Stat.dart';

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
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: FutureBuilder<Map<String, dynamic>>(
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
                    int lastWeekCarbon =
                        snapshot.data!['lastWeekCarbon'] as int;
                    int totalCarbon = snapshot.data!['totalCarbon'] as int;
                    double totalTons = snapshot.data!['totalTons'];
                    return SizedBox(
                      width: width,
                      height: height * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          const SizedBox(
                            child: Text("Total Carbon Saved",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0)),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          SizedBox(
                            child: Text("$totalCarbon lbs",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 80.0)),
                          ),
                          SizedBox(height: height * 0.005),
                          Container(
                            height: height * 0.24,
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
                                            fontSize: 25.0),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: primaryColor,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("Last Week:",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: Text("$lastWeekCarbon lbs",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
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
                                      width: width * 0.4,
                                      child: const Text("Total Tons:",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: Text("$totalTons tons",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
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
                                      width: width * 0.4,
                                      child: const Text("X",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("Y",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
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
                                      width: width * 0.4,
                                      child: const Text("X",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("Y",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.24,
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
                                            fontSize: 25.0),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: primaryColor,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("X",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("Y",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
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
                                      width: width * 0.4,
                                      child: const Text("X",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("Y",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
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
                                      width: width * 0.4,
                                      child: const Text("X",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("Y",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
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
                                      width: width * 0.4,
                                      child: const Text("X",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: const Text("Y",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: primaryFont,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)),
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
    );
  }
}
