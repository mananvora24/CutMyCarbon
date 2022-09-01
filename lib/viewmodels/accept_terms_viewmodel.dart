import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class AcceptTermsViewModel extends SharedViewModel {
  AcceptTermsViewModel();

  Future<void> saveAcceptedTerms() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserUsername)
        .update({
          'termsAccepted': true,
        })
        .then((value) => print("User accepted terms updated"))
        .catchError(
            (error) => print("Failed to update user accept terms: $error"));
  }
}
