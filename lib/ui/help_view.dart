import 'package:cut_my_carbon/viewmodels/aboutus_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            title: const Text('Help',
                style: TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Selecting A Tip",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 25,
                      ),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Add help text to explain how to select a Tip, what to do after selecting a tip.",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Following A Tip",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 25,
                      ),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Add help text to explain how to perform a selected Tip, when to report progress.",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Reporting Progress",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 25,
                      ),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Add help text to explain how to report progress.",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
