import 'package:cut_my_carbon/viewmodels/tip.dart';
import 'package:cut_my_carbon/viewmodels/tips_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TipsView extends StatelessWidget {
  const TipsView({
    Key? key,
    required this.user,
    required this.category,
    required this.skip,
    required this.tipOverride,
    required this.tipMax,
  }) : super(key: key);
  final String user;
  final String category;
  final bool skip;
  final int tipOverride;
  final int tipMax;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TipsData tipsData = TipsData(category: "", user: "", tipOrder: 0, tip: "");
    int tipOrder = 0;

    return ChangeNotifierProvider(
      create: (context) => TipsViewModel(),
      child: Consumer<TipsViewModel>(
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
              title: Text(category,
                  style: const TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * .8,
                      child: const Text("Carbon saving recommendation:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: primaryFont,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0)),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    SizedBox(
                      width: width * .8,
                      child: FutureBuilder<TipsData>(
                          future: model.getTipForUser(
                              category, currentUserUsername, skip, tipOverride),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<TipsData> snapshot,
                          ) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text(
                                  'getTipForUser returned Error',
                                  style: TextStyle(
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                tipsData = snapshot.data!;
                                tipOrder = tipsData.tipOrder;
                                print("TipsData: $tipsData");
                                return Text(tipsData.tip,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: primaryFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: primaryColor,
                                    ));
                              } else {
                                return const Text(
                                  'Empty data',
                                  style: TextStyle(
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                );
                              }
                            } else {
                              return Text(
                                'State: ${snapshot.connectionState}',
                                style: const TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                ),
                              );
                            }
                          }),
                    ),
                    SizedBox(height: height * 0.07),
                  ]),
            ),
            persistentFooterButtons: [
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () {
                  int override = tipOverride + 1;
                  if (tipOrder > override && !skip) {
                    override = tipOrder;
                  }

                  if (override >= tipMax) {
                    override = 0;
                  }
                  model.routeToTipsView(user, category, true, override, tipMax);
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () {
                  // Update Status
                  // Navigate to next page
                  // pass correct args
                  print("Select Button Pressed: TipsData - $tipsData");
                  // Save that this tip was selected
                  // --- Update tipStatus - save this tip is selected
                  // --- Create / Update user tip
                  model.selectTip(
                      currentUserUsername, category, tipsData.tipOrder);

                  model.routeToTipSelectedView(category, tipsData.tipOrder);
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Select',
                  style: TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                    fontSize: 20,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
