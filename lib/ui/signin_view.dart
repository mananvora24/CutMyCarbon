import 'package:firebase_auth/firebase_auth.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:cut_my_carbon/viewmodels/signin_viewmodel.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool _isExecuting = false;
    void debounce(Function action) async {
      if (!_isExecuting) {
        _isExecuting = true;
        action();
        await Future.delayed(const Duration(milliseconds: 500), () {
          _isExecuting = false;
        });
      }
    }

    //inputUsername = '';
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
                    height: height * 0.1,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                    alignment: Alignment.topRight,
                  ),
                  Text(message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: primaryFont,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  const Text('Enter your username',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: primaryFont,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      onChanged: (String value) {
                        inputUsername = value;
                        print(
                            "Input user value: $value, inputUserName: $inputUsername");
                      },
                      onSubmitted: (value) {
                        //print("search");
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
                  //debounce(() async {
                  String checkingNewUser = await model.getUsername(
                      inputUsername, currentUserProvider);
                  if (inputUsername == checkingNewUser) {
                    print(
                        'This input username $inputUsername is taken - checkingNewUser = $checkingNewUser');
                    model.routeToSignInView(
                        'The user name $inputUsername is taken');
                  } else {
                    await model.saveUsername(
                        user!.uid, inputUsername, currentUserProvider);
                    print(inputUsername + checkingNewUser);
                    currentUserUsername = inputUsername;

                    model.routeToAcceptTermsView();
                  }
                  //});
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
