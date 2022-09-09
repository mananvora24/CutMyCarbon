import 'package:cut_my_carbon/viewmodels/feedback_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FeedbackView extends StatelessWidget {
  FeedbackView({Key? key}) : super(key: key);

  String textHolder = "";
  void clickFunction() {
    textHolder = "Thank you for your submission";
  }

  final reasonController = TextEditingController();
  final feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => FeedbackViewModel(),
      child: Consumer<FeedbackViewModel>(
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
              title: const Text('Feedback',
                  style: TextStyle(
                      fontFamily: primaryFont,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0)),
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.08,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Reason",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.85,
                  child: TextField(
                    onChanged: (String value) {
                      model.reason = value;
                    },
                    keyboardType: TextInputType.text,
                    controller: reasonController,
                    style: const TextStyle(
                        fontFamily: primaryFont, color: primaryColor),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      labelText: 'Reason',
                      labelStyle: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Feedback",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.85,
                  child: TextField(
                    maxLines: 10,
                    onChanged: (String value) {
                      model.feedback = value;
                    },
                    keyboardType: TextInputType.text,
                    controller: feedbackController,
                    style: const TextStyle(
                        fontFamily: primaryFont, color: primaryColor),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      labelText: 'Feedback',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      clickFunction;
                      await model.saveFeedbackData(
                          currentUserUsername, model.reason, model.feedback);
                      String msg = "Thank you for your submission";
                      model.routeToFeedbackThanksView(
                          model.reason, model.feedback, msg);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        padding: const EdgeInsets.all(10)),
                    child: const Text('Submit',
                        style: TextStyle(
                          fontFamily: primaryFont,
                          color: whiteColor,
                          fontSize: largeButtonFontSize,
                        )),
                  ),
                ),
              ],
            )))),
      ),
    );
  }
}
