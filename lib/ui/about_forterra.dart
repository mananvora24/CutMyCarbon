import 'package:cut_my_carbon/viewmodels/aboutforterra_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class AboutFView extends StatelessWidget {
  const AboutFView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
            title: const Text('About Green Seattle Partnership: The Green Seattle Partnership is a collaboration between the City of Seattle, Forterra, community groups and non-profits, businesses, schools, and thousands of volunteers working together to restore and actively maintain the City’s forested parklands. The Green Seattle Partnership coordinates restoration projects to care for our urban forest and bring people into the parks to build community through hands-on volunteerism. Volunteering with the Green Seattle Partnership is a great way to give back to your community, get outside, and improve the health of a local park. Everyone can help keep our forested parks healthy and green! No experience necessary. Find a community event at the map and calendar linked below. Questions? Please email us at info@greenseattle.org. Volunteering with the Green Seattle Partnership: \nhttps://greenseattle.org/get-involved/volunteer/ \n\nLink to Events Calendar: \nhttps://seattle.greencitypartnerships.org/event/map/',
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
                Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "This is about Forterra. It is the sponsor of this App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: primaryFont,
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                  height: height * 0.13,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
