import 'package:cut_my_carbon/viewmodels/fun_fact_viewmodel.dart';
import 'package:flutter/material.dart';
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
          body: const Center(
              child: Text("This is a fun fact and how much carbon u saved.")),
        ),
      ),
    );
  }
}
