import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:cut_my_carbon/viewmodels/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class DeleteUserView extends StatelessWidget {
  const DeleteUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            title: const Text('Delete User',
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
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: const Text(
                      'Are you sure you want to delete your account? All of your user information and data will be lost.',
                      style: TextStyle(
                          fontFamily: primaryFont,
                          color: primaryColor,
                          fontSize: largeButtonFontSize),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(10)),
                        onPressed: () async {
                          model.deleteUser(currentUserUsername);
                          final provider = Provider.of<GoogleSigninProvider>(
                              context,
                              listen: false);
                          await provider.logout();
                          model.routeToAuthView();
                        },
                        child: const Text(
                          'Confirm Delete',
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
                          model.routeToHomeView();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontFamily: primaryFont,
                              color: whiteColor,
                              fontSize: largeButtonFontSize),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}
