import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class SignInViewModel extends SharedViewModel {
  SignInViewModel();
  String username = '';

  saveUsername(String uID, String userDisplayName, String userEmail,
      String username) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(username)
        .set({
          'uID': uID,
          'userDisplayName': userDisplayName,
          'userEmail': userEmail,
          'username': username,
          'termsAccepted': false,
        }, SetOptions(merge: true))
        .then((value) => print("Feedback complete Updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }

  Future<String> getUsername(String myUser) async {
    Map<String, dynamic> currentUser = {};
    String user = '';
    await FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: myUser)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("getCurrentUser: Data is empty");
      } else if (data.isNotEmpty) {
        print("getCurrentUser: Data Found");
        for (var snapshot in data) {
          currentUser = snapshot.data();
          user = currentUser['username'];
          break;
        }
      }
    });
    return user;
  }
}
