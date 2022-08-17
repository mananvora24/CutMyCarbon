import 'package:cut_my_carbon/viewmodels/stats_viewmodel.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../models/Stat.dart';

class StatsView extends StatelessWidget {
  const StatsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatsViewModel(),
      child: Consumer<StatsViewModel>(
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
          body: FutureBuilder<Map<String, dynamic>>(
              future: model.getUserStatistics('user1234'),
              builder: (
                BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    int lastWeekCarbon =
                        snapshot.data!['lastWeekCarbon'] as int;
                    int totalCarbon = snapshot.data!['totalCarbon'] as int;
                    double totalTons = snapshot.data!['totalTons'];
                    return Text(
                        "Last Week: $lastWeekCarbon lbs\n\n        Total Carbon: $totalCarbon lbs\n\n     Total Tons: $totalTons tons",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0));
                  } else {
                    return const Text('Error');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
        ),
      ),
    );
  }
}
