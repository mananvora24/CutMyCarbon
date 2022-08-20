import 'package:cut_my_carbon/viewmodels/suggest_a_tip_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class suggestATipView extends StatelessWidget {
  suggestATipView({Key? key, required this.title}) : super(key: key);
  final String title;
  final categoryController = TextEditingController();
  final tipController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => SuggestATipViewModel(),
      child: Consumer<SuggestATipViewModel>(
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
              title: const Text('Suggest A Tip',
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
                  height: height * 0.08,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Category",
                      textAlign: TextAlign.left,
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
                  child: TextField(
                    onChanged: (String value) {
                      model.category = value;
                      print(value);
                    },
                    controller: categoryController,
                    style: const TextStyle(
                        fontFamily: primaryFont, color: primaryColor),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      labelText: 'Category',
                      labelStyle: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Tip",
                      textAlign: TextAlign.left,
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
                  child: TextField(
                    maxLines: 10,
                    onChanged: (String value) {
                      model.tip = value;
                      print(value);
                    },
                    controller: tipController,
                    style: const TextStyle(
                        fontFamily: primaryFont, color: primaryColor),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      labelText: 'Tip',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      await model.saveTipSuggestionData(
                          currentUserUsername, model.category, model.tip);
                      model.routeToHomeView();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        padding: const EdgeInsets.all(10)),
                    child: const Text('Submit',
                        style: TextStyle(
                          fontFamily: primaryFont,
                          color: whiteColor,
                          fontSize: 20,
                        )),
                  ),
                ),
              ],
            )))),
      ),
    );
  }
}
