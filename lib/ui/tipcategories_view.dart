import 'package:cut_my_carbon/viewmodels/tips_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipCategoriesView extends StatelessWidget {
  const TipCategoriesView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TipsViewModel(),
      child: Consumer<TipsViewModel>(
        builder: (context, model, child) => Scaffold(
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            body: Center(
                child: Column(children: [
              const SizedBox(height: 70),
              const Text(
                  "Pick one of the categories to get your tip of the week"),
              OutlinedButton(
                  onPressed: () {
                    model.routeToTipsView("Home");
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              OutlinedButton(
                  onPressed: () {
                    model.routeToTipsView("Food");
                  },
                  child: const Text(
                    'Food',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              OutlinedButton(
                  onPressed: () {
                    model.routeToTipsView("Shopping");
                  },
                  child: const Text(
                    'Shopping',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              OutlinedButton(
                  onPressed: () {
                    model.routeToTipsView("Offsetting");
                  },
                  child: const Text(
                    'Offsetting',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              OutlinedButton(
                  onPressed: () {
                    model.routeToTipsView("Energy");
                  },
                  child: const Text(
                    'Energy Usage',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              OutlinedButton(
                  onPressed: () {
                    model.routeToTipsView("Water");
                  },
                  child: const Text(
                    'Water Usage',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              OutlinedButton(
                  onPressed: () {
                    model.routeToTipsView("Transportation");
                  },
                  child: const Text(
                    'Transportation',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ])),
            persistentFooterButtons: [
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  model.routeToHomeView();
                },
                onLongPress: () {
                  model.routeToHomeView();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 30),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
