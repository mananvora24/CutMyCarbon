import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cut_my_carbon/viewmodels/auth_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
        child: Consumer<AuthViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
                child: Center(
                    child: SizedBox(
              height: 200,
              child: SizedBox(
                height: (MediaQuery.of(context).size.height),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(10)),
                        onPressed: () async {
                          print('a');
                          final provider = Provider.of<GoogleSigninProvider>(
                              context,
                              listen: false);
                          print('b');
                          await provider.googleLogin();
                          user = FirebaseAuth.instance.currentUser;
                          String username;
                          username = await model.getUsername(user!.uid);
                          currentUserUsername = username;
                          print(
                              'user is logged in - User name is: $currentUserUsername');
                          if (username == '') {
                            print('Matched empty string $username this is uID');
                            model.routeToSignInView();
                          } else {
                            print('$username this is uID');
                            model.routeToHomeView();
                          }
                        },
                        icon: const FaIcon(FontAwesomeIcons.google,
                            color: whiteColor),
                        label: const Text('Sign Up with Google',
                            style: TextStyle(
                                fontFamily: primaryFont, color: whiteColor)),
                      ),
                    ]),
              ),
            ))),
          ),
        ));
  }
}
