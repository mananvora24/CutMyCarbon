import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:cut_my_carbon/ui/feedback_view.dart';

class FeedbackViewModel extends SharedViewModel {
  FeedbackViewModel();
  String reason = '';
  String feedback = '';

  saveFeedbackData(
      String user, String reasonEntered, String feedbackEntered) async {
    await FirebaseFirestore.instance
        .collection('Feedback')
        .doc()
        .set({
          'user': 'user1234',
          'reason': reasonEntered,
          'feedback': feedbackEntered,
        }, SetOptions(merge: true))
        .then((value) => print("Feedback complete Updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }
}
