import 'package:firebase_auth/firebase_auth.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:cut_my_carbon/viewmodels/signin_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
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
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: Center(
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
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    onChanged: (String value) {
                      model.username = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'username',
                    ),
                  ),
                ),
              ]),
            ),
            persistentFooterButtons: [
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () async {
                  String checkingNewUser =
                      await model.getUsername(model.username);
                  if (model.username == checkingNewUser) {
                    print('This username is taken');
                  } else {
                    await model.saveUsername(user!.uid, user.displayName ?? '',
                        user.email ?? '', model.username);
                    print(model.username + checkingNewUser);
                    model.routeToHomeView('user1234');
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
                    color: primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
