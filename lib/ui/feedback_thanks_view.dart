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
              automaticallyImplyLeading: false,
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
                      SizedBox(
                        width: width * 0.8,
                        child: const Text(
                          "Reason",
                          style: TextStyle(
                              fontFamily: primaryFont,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0),
                        ),
                      ),
                      const Divider(
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: width * 0.8,
                        child: Text(
                          reason,
                          style: const TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
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
                      SizedBox(
                        width: width * 0.8,
                        child: const Text(
                          "Feedback",
                          style: TextStyle(
                              fontFamily: primaryFont,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0),
                        ),
                      ),
                      const Divider(
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: width * 0.8,
                        child: Text(
                          feedback,
                          style: const TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
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
              ],
            )))),
      ),
    );
  }
}
