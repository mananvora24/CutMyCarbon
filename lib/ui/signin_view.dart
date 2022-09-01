import 'package:firebase_auth/firebase_auth.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:cut_my_carbon/viewmodels/signin_viewmodel.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    double height = MediaQuery.of(context).size.height;
    inputUsername = '';
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.25,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                    alignment: Alignment.topRight,
                  ),
                  const Text('Enter your username',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: primaryFont,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      onChanged: (String value) {
                        inputUsername = value;
                        print(
                            "Input user value: $value, inputUserName: $inputUsername");
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        labelText: 'username',
                        labelStyle: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            persistentFooterButtons: [
              ElevatedButton(
                onPressed: () async {
                  String checkingNewUser = await model.getUsername(
                      inputUsername, currentUserProvider);
                  if (inputUsername == checkingNewUser) {
                    print(
                        'This input username $inputUsername is taken - checkingNewUser = $checkingNewUser');
                    const Text('This username is taken',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0));
                  } else {
                    await model.saveUsername(
                        user!.uid, inputUsername, currentUserProvider);
                    print(inputUsername + checkingNewUser);
                    currentUserUsername = inputUsername;

                    model.routeToAcceptTermsView();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  minimumSize: const Size(170, 30),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: whiteColor,
                    fontFamily: primaryFont,
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
