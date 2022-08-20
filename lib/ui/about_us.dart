import 'package:cut_my_carbon/viewmodels/aboutus_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => AboutUsViewModel(),
      child: Consumer<AboutUsViewModel>(
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
            title: const Text('About Us',
                style: TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                  child: Text(
                "This is about Cut My Carbon.",
                style: TextStyle(
                  fontFamily: primaryFont,
                  color: primaryColor,
                  fontSize: 20,
                ),
              )),
              SizedBox(
                height: height * 0.13,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
