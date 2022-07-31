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
          appBar: AppBar(
            /*automaticallyImplyLeading: true,*/
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            elevation: 0,
          ),
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
                  'Energy',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            OutlinedButton(
                onPressed: () {
                  model.routeToTipsView("Water");
                },
                child: const Text(
                  'Water',
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
        ),
      ),
    );
  }
}
