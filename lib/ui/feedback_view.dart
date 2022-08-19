import 'package:cut_my_carbon/viewmodels/feedback_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FeedbackView extends StatelessWidget {
  FeedbackView({Key? key, required this.title}) : super(key: key);
  final String title;
  final reasonController = TextEditingController();
  final feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: Center(
                child: Column(
              children: [
                TextField(
                  onChanged: (String value) {
                    model.reason = value;
                    print(value);
                  },
                  controller: reasonController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason',
                  ),
                ),
                TextField(
                  onChanged: (String value) {
                    model.feedback = value;
                    print(value);
                  },
                  controller: feedbackController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Feedback',
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      await model.saveFeedbackData(
                          currentUserUsername, model.reason, model.feedback);
                      model.routeToHomeView();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        padding: const EdgeInsets.all(10)),
                    child: const Text('Submit',
                        style: TextStyle(color: whiteColor)),
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
