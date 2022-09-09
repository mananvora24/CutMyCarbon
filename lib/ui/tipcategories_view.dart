import 'package:cut_my_carbon/core/utilities/route_names.dart';
import 'package:cut_my_carbon/ui/home_view.dart';
import 'package:cut_my_carbon/viewmodels/tips_viewmodel.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TipCategoriesView extends StatelessWidget {
  const TipCategoriesView({Key? key, required this.user}) : super(key: key);
  final String user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => TipsViewModel(),
      child: Consumer<TipsViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: primaryColor,
              ),
              onPressed: () {
                // Navigator.pop(context);
                // Need to pop out everything
                model.popAllAndRouteToHome();
              },
            ),
            title: const Text('Select Category',
                style: TextStyle(
                    fontFamily: primaryFont,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  SizedBox(height: height * 0.1),
                  SizedBox(
                    width: width * 0.9,
                    child: const Text(
                      "Pick one of the categories to get your tip of the week",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(7)),
                        onPressed: () async {
                          int tipMax = await model
                              .getMaxCategoryTipOrder(categoryRecycling);
                          model.routeToTipsView(user, categoryRecycling, false,
                              0, tipMax); // tipOverride = 0
                        },
                        child: const Text(
                          categoryRecycling,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: whiteColor,
                            fontSize: 24,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(7)),
                        onPressed: () async {
                          int tipMax =
                              await model.getMaxCategoryTipOrder(categoryFood);
                          model.routeToTipsView(user, categoryFood, false, 0,
                              tipMax); // tipOverride = 0
                        },
                        child: const Text(
                          categoryFood,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: whiteColor,
                            fontSize: 24,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(7)),
                        onPressed: () async {
                          int tipMax = await model
                              .getMaxCategoryTipOrder(categoryShopping);
                          model.routeToTipsView(user, categoryShopping, false,
                              0, tipMax); // tipOverride = 0
                        },
                        child: const Text(
                          categoryShopping,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: whiteColor,
                            fontSize: 24,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(7)),
                        onPressed: () async {
                          int tipMax = await model
                              .getMaxCategoryTipOrder(categoryEnergy);
                          model.routeToTipsView(user, categoryEnergy, false, 0,
                              tipMax); // tipOverride = 0
                        },
                        child: const Text(
                          categoryEnergy,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: whiteColor,
                            fontSize: 24,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(7)),
                        onPressed: () async {
                          int tipMax =
                              await model.getMaxCategoryTipOrder(categoryWater);
                          model.routeToTipsView(user, categoryWater, false, 0,
                              tipMax); // tipOverride = 0
                        },
                        child: const Text(
                          categoryWater,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: whiteColor,
                            fontSize: 24,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(7)),
                        onPressed: () async {
                          int tipMax = await model
                              .getMaxCategoryTipOrder(categoryTransportation);
                          model.routeToTipsView(user, categoryTransportation,
                              false, 0, tipMax); // tipOverride = 0
                        },
                        child: const Text(
                          categoryTransportation,
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: whiteColor,
                            fontSize: 24,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}
