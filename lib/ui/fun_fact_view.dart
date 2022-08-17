import 'package:cut_my_carbon/viewmodels/fun_fact_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:provider/provider.dart';

class FunFactView extends StatelessWidget {
  const FunFactView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FunFactViewModel(),
      child: Consumer<FunFactViewModel>(
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
          body: const Center(
              child: Text("This is a fun fact and how much carbon u saved.")),
        ),
      ),
    );
  }
}
