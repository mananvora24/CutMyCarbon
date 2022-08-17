import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class SignInViewModel extends SharedViewModel {
  SignInViewModel();
  String username = '';

  saveUsername(String uID, String userDisplayName, String userEmail,
      String username) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc("$username")
        .set({
          'uID': uID,
          'userDisplayName': userDisplayName,
          'userEmail': userEmail,
          'username': username
        }, SetOptions(merge: true))
        .then((value) => print("Feedback complete Updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }
}
