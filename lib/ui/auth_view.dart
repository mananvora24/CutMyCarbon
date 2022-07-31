import 'package:cut_my_carbon/core/utilities/route_names.dart';
import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:cut_my_carbon/ui/home_view.dart';
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
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(),
          backgroundColor: const Color.fromARGB(255, 119, 188, 63),
          body: Column(children: [
            ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.black),
                label: Text('Sign Up with Google')),
            StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  model.routeToHomeView();
                  return Text('');
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error"));
                } else {
                  return Text('');
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
