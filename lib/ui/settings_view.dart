import 'package:cut_my_carbon/google_sign_in.dart';
import 'package:cut_my_carbon/viewmodels/settings_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
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
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: Center(
              child: Column(children: [
            CircleAvatar(
                radius: 43,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user!.photoURL!),
                )),
            SizedBox(
              height: 8,
            ),
            Text(user.displayName!),
            SizedBox(
              height: 8,
            ),
            Text(user.email!),
            ElevatedButton(
                onPressed: () async {
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  await provider.logout();
                  model.routeToAuthView();
                },
                child: Text('Logout'))
          ])),
        ),
      ),
    );
  }
}
