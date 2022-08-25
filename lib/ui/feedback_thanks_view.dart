import 'package:cut_my_carbon/viewmodels/feedback_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FeedbackThanksView extends StatelessWidget {
  const FeedbackThanksView(
      {Key? key,
      required this.reason,
      required this.feedback,
      required this.message})
      : super(key: key);
  final String reason;
  final String feedback;
  final String message;

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
                  height: height * 0.03,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: Text(
                      message,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                  height: height * 0.03,
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
                    enabled: false,
                    style: const TextStyle(
                        fontFamily: primaryFont, color: primaryColor),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      labelText: reason,
                      labelStyle: const TextStyle(
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
                    enabled: false,
                    style: const TextStyle(
                        fontFamily: primaryFont, color: primaryColor),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      labelText: feedback,
                      //hintText: feedback,
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      model.routeToHomeView();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        padding: const EdgeInsets.all(10)),
                    child: const Text('Home',
                        style: TextStyle(
                          fontFamily: primaryFont,
                          color: whiteColor,
                          fontSize: 20,
                        )),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            )))),
      ),
    );
  }
}
