import 'package:cut_my_carbon/viewmodels/stats_viewmodel.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

//import '../models/Stat.dart';

class StatsView extends StatelessWidget {
  const StatsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => StatsViewModel(),
      child: Consumer<StatsViewModel>(
        builder: (context, model, child) => Scaffold(
          
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: FutureBuilder<Map<String, dynamic>>(
              
                future: model.getUserStatistics(currentUserUsername),
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
                      return Container(
                        width: width,
                        height: height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: height*0.02),
                            SizedBox(
                              child: Text(
                                "$totalCarbon lbs ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60.0
                                )
                              ),
                            ),
                            const SizedBox(
                              child: Text(
                                "Total Carbon Saved",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0
                                )
                              ),
                            ),
                            SizedBox(height: height*0.1),
                            Row(
                              children: [
                                Column(
                                  children:  [
                                    SizedBox(
                                      width: width*0.5,
                                      child: Text(
                                        "Last Week: \n $lastWeekCarbon lbs",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0
                                        )
                                      ),
                                    ),
                                    SizedBox(height: height*0.02,),
                                    SizedBox(
                                      width: width*0.5,
                                      child: Text(
                                        "Total Tons: \n $totalTons tons",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children:  [
                                    SizedBox(
                                      width: width*0.5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],),
                          /*
                          Last Week: $lastWeekCarbon lbs\n\n        
                          Total Carbon: $totalCarbon lbs\n\n     
                          Total Tons: $totalTons tons
                          */
                        
                      );
                    } else {
                      return const Text('Error');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
            persistentFooterButtons: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    model.routeToHomeView('user1234');
                  },
                  onLongPress: () {
                    model.routeToHomeView('user1234');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    minimumSize: const Size(170, 30),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ]
          ),
      ),
    );
  }
}
