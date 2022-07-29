import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipStatusUpdateView extends StatelessWidget {
  const TipStatusUpdateView(
      {Key? key, required this.category, required String title})
      : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
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
          body: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              alignment: Alignment.topCenter,
              child: Text(category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0)),
            ),
            const Center(
                /*
              child: FutureBuilder<String>(
                  future: model.getTipForUser(category, 'user1234'),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<String> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        return Text(snapshot.data!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0));
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
                  */
                ),
            const SizedBox(height: 80),
            Image.asset(
              'assets/Logo.png',
            ),
          ]),
        ),
      ),
    );
  }
}
