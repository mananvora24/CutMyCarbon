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
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Cut My Carbon helps to reduce carbon footprints. Reducing your carbon footprint is important because it mitigates the effects of global climate change, improves public health, boost the global economy, and maintains biodiversity. Cut My Carbon will aid the Green Seattle Project, in partnership with Forterra.",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: textNormalFontSize,
                      ),
                    )),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                    width: width * 0.85,
                    child: const Text(
                      "Cut My Carbon App provides users quick and easy tips to lower their carbon footprints. Cut My Carbon will lower trash going to landfills, promote recycling, help clean the atmosphere and oceans, and work towards the global mission on reversing the effects of climate change",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: textNormalFontSize,
                      ),
                    )),
                const SizedBox(height: 20),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
