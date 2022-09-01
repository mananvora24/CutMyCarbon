import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class SignInViewModel extends SharedViewModel {
  SignInViewModel();

  saveUsername(String uID, String username, String provider) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(username)
        .set({
          'uID': uID,
          'username': username,
          'provider': provider,
          'termsAccepted': false,
        }, SetOptions(merge: true))
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<String> getUsername(String myUser, String provider) async {
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
