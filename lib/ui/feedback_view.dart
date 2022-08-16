import 'package:cut_my_carbon/viewmodels/feedback_viewmodel.dart';
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
              /*automaticallyImplyLeading: true,*/
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
                ElevatedButton(
                    onPressed: () async {
                      await model.saveFeedbackData(
                          'user1234', model.reason, model.feedback);
                      model.routeToHomeView('user1234');
                    },
                    child: const Text('Submit'))
              ],
            ))),
      ),
    );
  }
}
