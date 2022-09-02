import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends SharedViewModel {
  SettingsViewModel();

  deleteUser(String username) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(username)
        .delete()
        .then((value) => print("User complete delete"))
        .catchError((error) => print("Failed to update feedback: $error"));
    // delete the user stats along with the user so that the user does not end up tracking old stats for a different user
    await FirebaseFirestore.instance
        .collection('UserStatistics')
        .doc("${username}TipStats")
        .delete()
        .then((value) => print("UserStatistics complete delete"))
        .catchError((error) => print("Failed to update feedback: $error"));
    // delete the user tip tracker and status info
    await FirebaseFirestore.instance
        .collection('UserTipStatus')
        .doc("${username}TipCheck")
        .delete()
        .then((value) => print("UserTipStatus complete delete"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }

  Widget getDeleteButtonWidget(double width, BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: primaryColor, padding: const EdgeInsets.all(10)),
          onPressed: () async {
            routeToDeleteUserView();
          },
          child: const Text(
            'Delete User',
            style: TextStyle(
                fontFamily: primaryFont,
                color: whiteColor,
                fontSize: largeButtonFontSize),
          )),
    );
  }
}
