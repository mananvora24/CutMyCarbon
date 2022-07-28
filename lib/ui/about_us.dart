import 'package:cut_my_carbon/viewmodels/aboutus_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutUsViewModel(),
      child: Consumer<AboutUsViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            /*automaticallyImplyLeading: true,*/
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color.fromARGB(255, 119, 188, 63),
            elevation: 0,
          ),
          backgroundColor: const Color.fromARGB(255, 119, 188, 63),
          body: const Center(child: Text("This is about Cut My Carbon.")),
        ),
      ),
    );
  }
}
