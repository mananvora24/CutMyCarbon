import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class SignInViewModel extends SharedViewModel {
  SignInViewModel();
  String username = '';

  saveUsername(String uID, String username) async {
    if (currentUserProvider != '') {
      if (currentUserProvider == googleProvider) {
        await saveGoogleUsername(uID, username);
      } else if (currentUserProvider == appleProvider) {
        await saveAppleUsername(uID, username);
      }
    }
  }

  saveAppleUsername(String uID, String username) async {
    await FirebaseFirestore.instance
        .collection('AppleUsers')
        .doc(username)
        .set({
          'uID': uID,
          'username': username,
          'termsAccepted': false,
        }, SetOptions(merge: true))
        .then((value) => print("Feedback complete Updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }

  saveGoogleUsername(String uID, String username) async {
    await FirebaseFirestore.instance
        .collection('GoogleUsers')
        .doc(username)
        .set({
          'uID': uID,
          'username': username,
          'termsAccepted': false,
        }, SetOptions(merge: true))
        .then((value) => print("Feedback complete Updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }

  Future<String> getUsername(String myUser) async {
    if (currentUserProvider != '') {
      if (currentUserProvider == googleProvider) {
        return await getGoogleUsername(myUser);
      } else if (currentUserProvider == appleProvider) {
        return await getAppleUsername(myUser);
      }
    }
    return "";
  }

  Future<String> getAppleUsername(String myUser) async {
    Map<String, dynamic> currentUser = {};
    String user = '';
    await FirebaseFirestore.instance
        .collection('AppleUsers')
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

  Future<String> getGoogleUsername(String myUser) async {
    Map<String, dynamic> currentUser = {};
    String user = '';
    await FirebaseFirestore.instance
        .collection('GoogleUsers')
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
