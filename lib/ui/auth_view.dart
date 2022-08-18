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
              body: Center(
                  child: SizedBox(
                height: 200,
                child: SizedBox(
                  height: (MediaQuery.of(context).size.height),
                  child: Column(children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final provider = Provider.of<GoogleSigninProvider>(
                            context,
                            listen: false);
                        await provider.googleLogin();
                        print('user is logged in');
                        user = FirebaseAuth.instance.currentUser;
                        String uID1;
                        uID1 = await model.getUsername(user!.uid);
                        if (uID1 == '') {
                          print('Matched empty string $uID1 this is uID');
                          model.routeToSignInView();
                        } else {
                          print('$uID1 this is uID');
                          model.routeToHomeView(uID1);
                        }
                      },
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: primaryColor),
                      label: const Text('Sign Up with Google',
                          style: TextStyle(color: whiteColor)),
                    ),
                  ]),
                ),
              ))),
        ));
  }
}
