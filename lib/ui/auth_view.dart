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
    return ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
        child: Consumer<AuthViewModel>(
          builder: (context, model, child) => Scaffold(
              appBar: AppBar(),
              backgroundColor: const Color.fromARGB(255, 119, 188, 63),
              body: SizedBox(
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
                          model.routeToHomeView('user1234');
                        },
                        icon: const FaIcon(FontAwesomeIcons.google,
                            color: Colors.black),
                        label: const Text('Sign Up with Google')),
                  ]),
                ),
              )),
        ));
  }
}
