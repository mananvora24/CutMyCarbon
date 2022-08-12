import 'package:cut_my_carbon/viewmodels/tip_status_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cut_my_carbon/Forterra Icon/Ficon.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.user, required String title})
      : super(key: key);
  final String user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TipStatusData tipStatusData = TipStatusData(
        category: "",
        user: "",
        tipOrder: 0,
        tipSelected: false,
        tipCompleted: false);
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: const Color.fromARGB(255, 119, 188, 63),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.green,
            spacing: 15,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.settings_rounded),
                  backgroundColor: Colors.green,
                  onTap: () {}),
              SpeedDialChild(
                  child: const Icon(Icons.mail_rounded),
                  backgroundColor: Colors.green,
                  onTap: () {
                    model.routeToInboxView();
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.feedback_rounded),
                  backgroundColor: Colors.green,
                  onTap: () {}),
              SpeedDialChild(
                  child: const Icon(Icons.info_rounded),
                  backgroundColor: Colors.green,
                  onTap: () {
                    model.routeToAboutUSView();
                  }),
              SpeedDialChild(
                  child: const Icon(Forterra.logo),
                  backgroundColor: Colors.green,
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
              const SizedBox(height: 80),
              Image.asset(
                'assets/Logo.png',
              ),
              const SizedBox(height: 60),
              SizedBox(
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      //tipStatusData = await model.checkTipStatus('user1234');
                      if (tipStatusData.tipSelected) {
                        model.routeToTipStatusUpdateView(tipStatusData.user,
                            tipStatusData.category, tipStatusData.tipOrder);
                      } else {
                        model.routeToTipCategoriesView('user1234');
                      }
                    },
                    onLongPress: () {
                      //tipStatusData = await model.checkTipStatus('user1234');
                      if (tipStatusData.tipSelected) {
                        model.routeToTipStatusUpdateView(tipStatusData.user,
                            tipStatusData.category, tipStatusData.tipOrder);
                      } else {
                        model.routeToTipCategoriesView('user1234');
                      }
                    },
                    style: ElevatedButton.styleFrom(
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
                              return Text(
                                  model.getTipsButtonText(tipStatusData),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 30.0));
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
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Text(
                      'Statistics',
                      style: TextStyle(
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
