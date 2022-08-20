import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:cut_my_carbon/viewmodels/tip_status_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cut_my_carbon/Forterra Icon/Ficon.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required String title}) : super(key: key);
  //String username = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TipStatusData tipStatusData = TipStatusData(
        category: "",
        user: "",
        tipOrder: 0,
        tipSelected: false,
        tipCompleted: false,
        tipStartTime: Timestamp.now());

    User? user = FirebaseAuth.instance.currentUser;
    currentUserUID = user!.uid;
    currentUserDisplayName = user.displayName!;
    currentUserUserEmail = user.email!;

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
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToSettingsView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.mail_rounded,
                    color: backgroundColor,
                  ),
                  label: 'Inbox',
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
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
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToFeedbackView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.info_rounded,
                    color: backgroundColor,
                  ),
                  label: 'About Us',
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToAboutUSView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Forterra.logo,
                    color: backgroundColor,
                  ),
                  label: 'Green Seattle Project',
                  labelStyle: const TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                  ),
                  backgroundColor: primaryColor,
                  onTap: () {
                    model.routeToAboutForterraView();
                  }),
            ],
          ),
          body: Center(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                alignment: Alignment.topRight,
              ),
              SizedBox(
                height: 30,
                child: FutureBuilder<String>(
                    future: model.getUsername(currentUserUID),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> snapshot,
                    ) {
                      String username;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          username = snapshot.data!;
                          print("HomeView: User - $username");
                          currentUserUsername = username;
                          return Text(username,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: primaryFont,
                                  color: primaryColor,
                                  fontSize: 25.0));
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
              const SizedBox(height: 80),
              Image.asset(
                'assets/Logo1.png',
              ),
              const SizedBox(height: 60),
              SizedBox(
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      int days = DateTime.now()
                          .difference(tipStatusData.tipStartTime.toDate())
                          .inDays;
                      print(
                          "tipStartTime: ${tipStatusData.tipStartTime.toDate()}");
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
                                      fontSize: 30.0));
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
              const SizedBox(height: 40),
              SizedBox(
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      model.routeToStatsView();
                    },
                    onLongPress: () {
                      model.routeToStatsView();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        padding: const EdgeInsets.all(10)),
                    child: const Text(
                      'Statistics',
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: whiteColor,
                        fontSize: 30,
                      ),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
