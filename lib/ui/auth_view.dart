import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:cut_my_carbon/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    double height = (MediaQuery.of(context).size.height);
    double width = (MediaQuery.of(context).size.width);
    return ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
        child: Consumer<AuthViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
                child: Center(
                    child: SizedBox(
              width: width,
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          "Welcome to Cut My Carbon!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Text(
                            "Did you know that the average American’s carbon footprint is 5 times the global average? Our mission is to achieve a carbon neutral world. So find a tip, start working, and cut your carbon! We would also like to emphasize that your account is not linked with any personal information like name or email address.", // Reducing your carbon footprint is important because it mitigates the effects of global climate change, improves public health, boost the global economy, and maintains biodiversity.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: primaryFont,
                              color: primaryColor,
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        child: SignInButton(
                          text: "Signin with Google",
                          Buttons.GoogleDark,
                          onPressed: () async {
                            final provider = Provider.of<GoogleSigninProvider>(
                                context,
                                listen: false);
                            await provider.googleLogin();
                            user = FirebaseAuth.instance.currentUser;
                            currentUserProvider = googleProvider;
                            String? uid = user?.uid;
                            if (uid == null || uid == '') {
                              // This is most likely due to cancel during sign in. So best to request sign in again
                              model.routeToAuthView();
                              return;
                            }
                            String username;
                            model.getUsername(uid, currentUserProvider).then(
                              (value) {
                                // username = value;
                                print(
                                    'user is logged in - User name is: $currentUserUsername');
                                if (currentUserUsername == '') {
                                  print(
                                      'Matched empty string for email = $uid, username = $currentUserUsername');
                                  model.routeToSignInView('');
                                  return;
                                } else if (currentUserTermsAccepted) {
                                  model.routeToHomeView();
                                  return;
                                } else {
                                  print(
                                      '$currentUserUsername has not accepted terms');
                                  model.routeToAcceptTermsView();
                                  return;
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SignInButton(
                        Buttons.AppleDark,
                        text: "Signin with Apple",
                        //style: ElevatedButton.styleFrom(
                        //  primary: primaryColor,
                        //padding: const EdgeInsets.all(10)),
                        onPressed: () async {
                          final provider = Provider.of<GoogleSigninProvider>(
                              context,
                              listen: false);
                          UserCredential appleUser =
                              await provider.signInWithApple();
                          currentUserProvider = appleProvider;

                          user = FirebaseAuth.instance.currentUser;
                          print(
                              'Apple User object: $appleUser, vs Firebase Auth User object: $user');
                          String? uid = user?.uid;
                          if (uid == null || uid == '') {
                            // This is most likely due to cancel during sign in. So best to request sign in again
                            model.routeToAuthView();
                            return;
                          }

                          String username;
                          username = await model.getUsername(
                              user!.uid, currentUserProvider);
                          currentUserUsername = username;
                          print(
                              'user is logged in - User name is: $currentUserUsername');
                          if (username == '') {
                            print('Matched empty string $username this is uID');
                            model.routeToSignInView('');
                          } else if (currentUserTermsAccepted) {
                            print('$username this is uID');
                            model.routeToHomeView();
                          } else {
                            print('$username has not accepted terms');
                            model.routeToAcceptTermsView();
                          }
                        },
                      ),
                    ]),
              ),
            ))),
          ),
        ));
  }
}
