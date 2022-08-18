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
  HomeView({Key? key, required String title}) : super(key: key);
  String username = '';

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
            children: [
              SpeedDialChild(
                  child: const Icon(
                    Icons.settings_rounded,
                    color: primaryColor,
                  ),
                  backgroundColor: backgroundColor,
                  onTap: () {
                    model.routeToSettingsView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.mail_rounded,
                    color: primaryColor,
                  ),
                  backgroundColor: backgroundColor,
                  onTap: () {
                    model.routeToInboxView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.feedback_rounded,
                    color: primaryColor,
                  ),
                  backgroundColor: backgroundColor,
                  onTap: () {
                    model.routeToFeedbackView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.info_rounded,
                    color: primaryColor,
                  ),
                  backgroundColor: backgroundColor,
                  onTap: () {
                    model.routeToAboutUSView();
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Forterra.logo,
                    color: primaryColor,
                  ),
                  backgroundColor: backgroundColor,
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
                                  color: primaryColor, fontSize: 25.0));
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
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
                        model.routeToTipCategoriesView('user1234');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: const EdgeInsets.all(10),
                    ),
                    child: FutureBuilder<TipStatusData>(
                        future: model.checkTipStatus('user1234'),
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
                                      color: whiteColor, fontSize: 30.0));
                            } else {
                              return const Text('Empty data');
                            }
                          } else {
                            return Text('State: ${snapshot.connectionState}');
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
