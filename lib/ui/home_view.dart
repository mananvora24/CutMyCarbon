import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/tip_status_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cut_my_carbon/core/utilities/green_seattle_project_icons.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TipStatusData tipStatusData = TipStatusData(
        category: "",
        user: "",
        tipOrder: 0,
        tipSelected: false,
        tipCompleted: false,
        tipStartTime: Timestamp.now());

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserUID = user.uid;
      currentUserProvider = user.providerData[0].providerId;
    }

    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: primaryColor,
            spacing: 15,
            overlayOpacity: 0.95,
            children: [
              SpeedDialChild(
                  child: const Icon(
                    Icons.settings_rounded,
                    color: backgroundColor,
                  ),
                  label: 'Settings',
                  labelBackgroundColor: primaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToSettingsView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.help,
                    color: backgroundColor,
                  ),
                  label: 'Help',
                  labelBackgroundColor: primaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToHelpView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.mail_rounded,
                    color: backgroundColor,
                  ),
                  label: 'Inbox',
                  labelBackgroundColor: primaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToInboxView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.feedback_rounded,
                    color: backgroundColor,
                  ),
                  label: 'Feedback',
                  labelBackgroundColor: primaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToFeedbackView();
                  }),
              SpeedDialChild(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: const Icon(
                      Icons.add_comment,
                      color: whiteColor,
                    ),
                  ),
                  label: 'Suggest a Tip',
                  labelBackgroundColor: primaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToSuggestATipView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.info_rounded,
                    color: backgroundColor,
                  ),
                  label: 'About Us',
                  labelBackgroundColor: primaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToAboutUSView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    GreenSeattleProject.greenSeattle,
                    color: backgroundColor,
                  ),
                  label: 'Green Seattle Project',
                  labelBackgroundColor: primaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: whiteColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToAboutForterraView();
                  }),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    alignment: Alignment.topRight,
                  ),
                  SizedBox(height: height * 0.07),
                  Image.asset(
                    'assets/CMCLogo.png',
                  ),
                  SizedBox(height: height * 0.07),
                  SizedBox(
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          int days = DateTime.now()
                              .difference(tipStatusData.tipStartTime.toDate())
                              .inDays;
                          print(
                              "tipStartTime: ${tipStatusData.tipStartTime.toDate()}, Days = $days");
                          if (tipStatusData.tipSelected && days > 6) {
                            model.routeToTipStatusUpdateView(
                                tipStatusData.user,
                                tipStatusData.category,
                                tipStatusData.tipOrder,
                                tipStatusData.tipStartTime,
                                "");
                          } else if (tipStatusData.tipSelected && days < 7) {
                            model.routeToTipShowCurrentView(
                              tipStatusData.category,
                              tipStatusData.tipOrder,
                              tipStatusData.tipStartTime,
                            );
                          } else {
                            model.routeToTipCategoriesView(currentUserUsername);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          padding: const EdgeInsets.all(10),
                        ),
                        child: FutureBuilder<TipStatusData>(
                            future: model.checkTipStatus(currentUserUsername),
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<TipStatusData> snapshot,
                            ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  tipStatusData = snapshot.data!;
                                  return const Text("Tip",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: primaryFont,
                                          color: whiteColor,
                                          fontSize: largeButtonFontSize));
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
                      )),
                  SizedBox(height: height * 0.05),
                  SizedBox(
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          model.routeToStatsView();
                        },
                        onLongPress: () {
                          model.routeToAcceptTermsView();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(10)),
                        child: const Text(
                          'Statistics',
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: whiteColor,
                            fontSize: largeButtonFontSize,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: height * 0.06,
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
                            "Fun Fact of the Day",
                            style: TextStyle(
                                fontFamily: primaryFont,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 23.0),
                          ),
                        ),
                        const Divider(
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: FutureBuilder<String>(
                              future: model.getCategoryFact('Energy'),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<String> snapshot,
                              ) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    String funFact = snapshot.data!;
                                    return Text(funFact,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontFamily: primaryFont,
                                            color: primaryColor,
                                            fontSize: 20.0));
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
                  const SizedBox(height: 10),
                ]),
          ),
        ),
      ),
    );
  }
}
