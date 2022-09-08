import 'package:cut_my_carbon/viewmodels/aboutus_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => AboutUsViewModel(),
      child: Consumer<AboutUsViewModel>(
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
            title: const Text('About Us',
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
                Image.asset(
                  'assets/CMCLogo.png',
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Cut My Carbon is a simple way to lower your carbon footprint. With global temperatures rising everyday, it is more important now than ever that we reduce our climate impact. Just by following our weekly tips, you can significantly reduce your carbon output and make a real change. Our mission is to make a carbon neutral world where we work with mother nature cleaning the atmosphere and preserving habitats. While these tips won’t just fix the climate crisis, every little step we take will bring us closer to a carbon neutral world. Even though you might only save a few pounds, being aware and spreading the word is exactly what we need. So find a tip, start working, and cut your carbon!",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 17,
                      ),
                    )),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
