import 'package:cut_my_carbon/viewmodels/aboutforterra_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutFView extends StatelessWidget {
  const AboutFView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutForterraViewModel(),
      child: Consumer<AboutForterraViewModel>(
        builder: (context, model, child) => Scaffold(
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            body: const Center(
                child: Text(
                    "This is about Forterra. It is the sponsor of this App")),
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
                  minimumSize: const Size(170, 40),
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
