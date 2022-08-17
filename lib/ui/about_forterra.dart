import 'package:cut_my_carbon/viewmodels/aboutforterra_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class AboutFView extends StatelessWidget {
  const AboutFView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutForterraViewModel(),
      child: Consumer<AboutForterraViewModel>(
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
              child: Text(
                  "This is about Forterra. It is the sponsor of this App")),
        ),
      ),
    );
  }
}
