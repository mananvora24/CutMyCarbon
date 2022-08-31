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
                      "Tips",
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
                      "From the home page click \"Tip\". This shows a list of categories. Select a Categpry that you want to receive a tip in. Next, find a tip you would like to work on for the next week. To find a tip you prefer, you can use the \"Skip\" and \"Select\" buttons. Then you will be able to view your Tip. At the end of the week come back to report your progress, so that we can calculate your carbon savings.",
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
                      "Statistics",
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
                      "To find your total carbon savings, click on the \"Statistics\" button from the home page",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Feedback",
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
                      "The feedback form can be used to provide feedback to the Cut My Carbon team.",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Suggest a Tip",
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
                      "The Tip suggestion form can be used to suggest a tip to the Cut My Carbon team",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
