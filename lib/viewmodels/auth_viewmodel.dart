import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class AuthViewModel extends SharedViewModel {
  AuthViewModel();

  Future<String> getUsername(String email) async {
    Map<String, dynamic> currentUser = {};
    String user = '';
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userEmail', isEqualTo: email)
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
          currentUserUsername = user;
          currentUserUserEmail = currentUser['userEmail'];
          currentUserUID = currentUser['uID'];
          currentUserDisplayName = currentUser['userDisplayName'];
          //userDBFetch = true;
          break;
        }
      }
    });
    return user;
  }
}
