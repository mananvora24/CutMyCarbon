import 'package:cut_my_carbon/viewmodels/tip.dart';
import 'package:cut_my_carbon/viewmodels/tips_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipsView extends StatelessWidget {
  const TipsView({
    Key? key,
    required this.user,
    required this.category,
    required this.skipCount,
  }) : super(key: key);
  final String user;
  final String category;
  final int skipCount;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String tip = "";
    TipsData tipsData = TipsData(category: "", user: "", tipOrder: 0, tip: "");

    return ChangeNotifierProvider(
      create: (context) => TipsViewModel(),
      child: Consumer<TipsViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0)),
              backgroundColor: const Color.fromARGB(255, 119, 188, 63),
              elevation: 0,
            ),
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * .8,
                      child: const Text("Carbon saving recommendation:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0)),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    SizedBox(
                      width: width * .8,
                      child: FutureBuilder<TipsData>(
                          future: model.getTipForUser(
                              category, 'user1234', skipCount),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<TipsData> snapshot,
                          ) {
                            //
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Error');
                              } else if (snapshot.hasData) {
                                tipsData = snapshot.data!;
                                //print(
                                //    "Tips View Model : getTipForUser :  TipsData - $tipsData");

                                return Text(tipsData.tip,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: Colors.white,
                                    ));
                              } else {
                                return const Text('Empty data');
                              }
                            } else {
                              return Text('State: ${snapshot.connectionState}');
                            }
                          }),
                    ),
                    SizedBox(height: height * 0.07),
                  ]),
            ),
            persistentFooterButtons: [
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () {
                  model.routeToTipsView(user, category, skipCount + 1);
                },
                onLongPress: () {
                  model.routeToTipsView(user, category, skipCount + 1);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () {
                  // Update Status
                  // Navigate to next page
                  // pass correct args
                  print("Select Button Pressed: TipsData - $tipsData");
                  // Save that this tip was selected
                  // --- Update tipStatus - save this tip is selected
                  // --- Create / Update user tip
                  model.selectTip('user1234', category, tipsData.tipOrder);

                  model.routeToTipSelectedView(category, tipsData.tipOrder);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 40),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
