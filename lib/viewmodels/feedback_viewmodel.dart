import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

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
          'user': currentUserUsername,
          'reason': reasonEntered,
          'feedback': feedbackEntered,
        }, SetOptions(merge: true))
        .then((value) => print("Feedback complete Updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }
}
