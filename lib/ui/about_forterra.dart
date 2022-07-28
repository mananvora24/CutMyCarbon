import 'package:cut_my_carbon/viewmodels/aboutforterra_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          backgroundColor: Color.fromARGB(255, 119, 188, 63),
          body: const Center(
              child: Text(
                  "This is about Forterra. It is the sponsor of this App")),
        ),
      ),
    );
  }
}
