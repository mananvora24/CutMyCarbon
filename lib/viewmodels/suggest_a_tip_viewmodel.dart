import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class SuggestATipViewModel extends SharedViewModel {
  SuggestATipViewModel();
  String category = '';
  String tip = '';

  saveTipSuggestionData(
      String user, String categoryEntered, String tipEntered) async {
    await FirebaseFirestore.instance
        .collection('SuggestedTips')
        .doc()
        .set({
          'user': currentUserUsername,
          'category': categoryEntered,
          'tip': tipEntered,
        }, SetOptions(merge: true))
        .then((value) => print("Tip suggestion complete Updated"))
        .catchError(
            (error) => print("Failed to update tip suggestion: $error"));
  }
}
