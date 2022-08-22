import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/tip.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TipSelectedView extends StatelessWidget {
  const TipSelectedView(
      {Key? key, required this.category, required this.tipOrder})
      : super(key: key);
  final String category;
  final int tipOrder;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TipsData tipsData = TipsData(
        category: "",
        user: "",
        tipOrder: 0,
        tip: "",
        description: "",
        carbon: 0);

    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor,
              elevation: 0,
              title: Text(category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: primaryFont,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: appBarFontSize)),
            ),
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.06),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      padding: const EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 15),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: width * 0.8,
                            child: const Text(
                              "Tip",
                              style: TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: boxTitleFontSize),
                            ),
                          ),
                          const Divider(
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: FutureBuilder<TipsData>(
                                future: model.getCurrentTip(
                                    category, tipOrder, currentUserUsername),
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
                                      //tipOrder = tipsData.tipOrder;
                                      print("TipsData: $tipsData");
                                      return Text(tipsData.tip,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontFamily: primaryFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: boxTextFontSize,
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
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      padding: const EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 15),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: width * 0.8,
                            child: const Text(
                              "Details",
                              style: TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: boxTitleFontSize),
                            ),
                          ),
                          const Divider(
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: FutureBuilder<TipsData>(
                                future: model.getCurrentTip(
                                    category, tipOrder, currentUserUsername),
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
                                      // tipOrder = tipsData.tipOrder;
                                      print("TipsData: $tipsData");
                                      return Text(tipsData.description,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontFamily: primaryFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: boxTextFontSize,
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
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      padding: const EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 15),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: width * 0.8,
                            child: const Text(
                              "Carbon saved per day",
                              style: TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: boxTitleFontSize),
                            ),
                          ),
                          const Divider(
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: FutureBuilder<TipsData>(
                                future: model.getCurrentTip(
                                    category, tipOrder, currentUserUsername),
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
                                      // tipOrder = tipsData.tipOrder;
                                      print("TipsData: $tipsData");
                                      return Text("${tipsData.carbon} lbs",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontFamily: primaryFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: boxTextFontSize,
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
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    const Text("Come back in 7 days to report your progress",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: textNormalFontSize)),
                  ]),
            ),
            persistentFooterButtons: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    model.routeToHomeView();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    minimumSize: const Size(170, 30),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: primaryFont,
                      color: whiteColor,
                      fontSize: regularButtonFontSize,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
