import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cut_my_carbon/Forterra Icon/Ficon.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  onTap: () {}),
              SpeedDialChild(
                  child: const Icon(Icons.feedback_rounded),
                  backgroundColor: Colors.green,
                  onTap: () {}),
              SpeedDialChild(
                  child: const Icon(Icons.tips_and_updates_rounded),
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height / 3,
                child: Image.asset(
                  'assets/Logo.png',
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    model.routeToTipCategoriesView();
                  },
                  onLongPress: () {
                    model.routeToTipCategoriesView();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Text(
                    'Select Tip',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
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
