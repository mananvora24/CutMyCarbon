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
                Navigator.pop(context);
              },
            ),
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          backgroundColor: backgroundColor,
          body: Center(
              child: Column(children: [
            const SizedBox(height: 70),
            SizedBox(
              width: width * 0.8,
              child: const Text(
                "Pick one of the categories to get your tip of the week",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () async {
                  int tipMax = await model.getMaxCategoryTipOrder(categoryHome);
                  model.routeToTipsView(
                      user, categoryHome, false, 0, tipMax); // tipOverride = 0
                },
                child: const Text(
                  categoryHome,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                )),
            OutlinedButton(
                onPressed: () async {
                  int tipMax = await model.getMaxCategoryTipOrder(categoryFood);
                  model.routeToTipsView(
                      user, categoryFood, false, 0, tipMax); // tipOverride = 0
                },
                child: const Text(
                  categoryFood,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                )),
            OutlinedButton(
                onPressed: () async {
                  int tipMax =
                      await model.getMaxCategoryTipOrder(categoryShopping);
                  model.routeToTipsView(user, categoryShopping, false, 0,
                      tipMax); // tipOverride = 0
                },
                child: const Text(
                  categoryShopping,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                )),
            OutlinedButton(
                onPressed: () async {
                  int tipMax =
                      await model.getMaxCategoryTipOrder(categoryEnergy);
                  model.routeToTipsView(user, categoryEnergy, false, 0,
                      tipMax); // tipOverride = 0
                },
                child: const Text(
                  categoryEnergy,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                )),
            OutlinedButton(
                onPressed: () async {
                  int tipMax =
                      await model.getMaxCategoryTipOrder(categoryWater);
                  model.routeToTipsView(
                      user, categoryWater, false, 0, tipMax); // tipOverride = 0
                },
                child: const Text(
                  categoryWater,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                )),
            OutlinedButton(
                onPressed: () async {
                  int tipMax = await model
                      .getMaxCategoryTipOrder(categoryTransportation);
                  model.routeToTipsView(user, categoryTransportation, false, 0,
                      tipMax); // tipOverride = 0
                },
                child: const Text(
                  categoryTransportation,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                )),
          ])),
        ),
      ),
    );
  }
}
