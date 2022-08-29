import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:cut_my_carbon/viewmodels/settings_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //User? user = FirebaseAuth.instance.currentUser;
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: Consumer<SettingsViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Settings',
                style: TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
/*
                  CircleAvatar(
                      radius: 43,
                      backgroundColor: primaryColor,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(user!.photoURL!),
                      )),
                      */
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    currentUserDisplayName,
                    style: const TextStyle(
                      fontFamily: primaryFont,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    currentUserUserEmail,
                    style: const TextStyle(
                      fontFamily: primaryFont,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(10)),
                        onPressed: () async {
                          final provider = Provider.of<GoogleSigninProvider>(
                              context,
                              listen: false);
                          await provider.logout();
                          model.routeToAuthView();
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                              fontFamily: primaryFont,
                              color: whiteColor,
                              fontSize: largeButtonFontSize),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(10)),
                        onPressed: () async {
                          model.routeToTermsView();
                        },
                        child: const Text(
                          'Terms',
                          style: TextStyle(
                              fontFamily: primaryFont,
                              color: whiteColor,
                              fontSize: largeButtonFontSize),
                        )),
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}
