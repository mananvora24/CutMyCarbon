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
    double height = (MediaQuery.of(context).size.height);
    return ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
        child: Consumer<AuthViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
                child: Center(
                    child: SizedBox(
              child: SizedBox(
                height: height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: const Text(
                          "Welcome to Cut My Carbon!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: const Text(
                            "Cut My Carbon helps to reduce carbon footprints.", // Reducing your carbon footprint is important because it mitigates the effects of global climate change, improves public health, boost the global economy, and maintains biodiversity.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: primaryFont,
                              color: primaryColor,
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: const Text(
                            "Cut My Carbon App provides users quick and easy tips to lower their carbon footprints. Are you ready to cat your carbon?",
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
                        width: 185,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              padding: const EdgeInsets.all(10)),
                          onPressed: () async {
                            final provider = Provider.of<GoogleSigninProvider>(
                                context,
                                listen: false);
                            await provider.googleLogin();
                            user = FirebaseAuth.instance.currentUser;
                            String? email = user?.email;
                            String username;
                            username = await model.getUsername(email!);
                            //currentUserUsername = username;
                            print(
                                'user is logged in - User name is: $currentUserUsername');
                            if (username == '') {
                              print(
                                  'Matched empty string for email = $email, username = $username');
                              model.routeToSignInView();
                            } else if (currentUserTermsAccepted) {
                              model.routeToHomeView();
                            } else {
                              print('$username has not accepted terms');
                              model.routeToAcceptTermsView();
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.google,
                              color: whiteColor),
                          label: const Text('Sign In with Google',
                              style: TextStyle(
                                  fontFamily: primaryFont, color: whiteColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 185,
                        child: ElevatedButton.icon(
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
                              print(
                                  'Matched empty string $username this is uID');
                              model.routeToAcceptTermsView();
                            } else {
                              print('$username this is uID');
                              model.routeToHomeView();
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.apple,
                              color: whiteColor),
                          label: const Text('Sign In with Apple',
                              style: TextStyle(
                                  fontFamily: primaryFont, color: whiteColor)),
                        ),
                      ),
                    ]),
              ),
            ))),
          ),
        ));
  }
}
