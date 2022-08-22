import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class TipStatusUpdateView extends StatelessWidget {
  const TipStatusUpdateView({
    Key? key,
    required this.user,
    required this.category,
    required this.tipOrder,
    required this.tipStartTime,
    required this.message,
  }) : super(key: key);
  final String user;
  final String category;
  final int tipOrder;
  final Timestamp tipStartTime;
  final String message;

  @override
  Widget build(BuildContext context) {
    TextEditingController daysController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
            title: const Text("Tip Progress",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: appBarFontSize)),
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                  alignment: Alignment.topRight,
                ),
                SizedBox(
                  height: 120,
                  width: width * 0.9,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: primaryFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.red),
                  ),
                ),
                SizedBox(
                  width: width * 0.8,
                  child: const Text(
                      'How many days did you successfully complete your tip?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: primaryFont,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: textNormalFontSize)),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.5,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: daysController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        //hintText: '1',
                        hintStyle: TextStyle(
                          fontFamily: primaryFont,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      String input = daysController.text;
                      var days = int.parse(daysController.text);
                      final now = Timestamp.now();
                      final int selectedDays =
                          now.toDate().difference(tipStartTime.toDate()).inDays;
                      print(
                          "Validator: input: $input, current time: $now, startTime: $tipStartTime, selectedDays: $selectedDays, days: $days");

                      String errorMessage =
                          "You started this tip $selectedDays days ago. You entered $days days.";
                      if (days > selectedDays) {
                        model.routeToTipStatusUpdateView(user, category,
                            tipOrder, tipStartTime, errorMessage);
                      } else {
                        model.submitTipsData(
                            currentUserUsername, category, tipOrder, days);
                        print(days);
                        model.routeToTipStatusResultView(
                            user, category, tipOrder, days);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(170, 30),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: whiteColor,
                        fontSize: regularButtonFontSize,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
