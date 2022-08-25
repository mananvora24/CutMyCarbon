import 'package:cut_my_carbon/viewmodels/aboutforterra_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class AboutFView extends StatelessWidget {
  const AboutFView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
            title: const Text('Green Seattle Project',
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  child: const Text(
                    "About the Green Seattle Partnership",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: primaryFont,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 20,
                      height: 1,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "The Green Seattle Partnership is a collaboration between the City of Seattle, Forterra, community groups and non-profits, businesses, schools, and thousands of volunteers working together to restore and actively maintain the City’s forested parklands.\n\nThe Green Seattle Partnership coordinates restoration projects to care for our urban forest and bring people into the parks to build community through hands-on volunteerism.\n\nVolunteering with the Green Seattle Partnership is a great way to give back to your community, get outside, and improve the health of a local park. Everyone can help keep our forested parks healthy and green! No experience necessary. Find a community event at the map and calendar linked below. Questions? Please email us at ",
                    style: TextStyle(
                      fontFamily: primaryFont,
                      color: primaryColor,
                      fontSize: 17,
                      height: 1.2,
                    ),
                  ),
                ),
                /*Container(
                  width: width,
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () async {
                      if (await canLaunch('mailto:info@greenseattle.org')) {
                        // ignore: deprecated_member_use
                        await launch('mailto:info@greenseattle.org');
                      }
                    },
                    child: const Text(
                      'info@greenseattle.org',
                      style: TextStyle(
                          fontSize: 17,
                          height: 1.2,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),*/
                SizedBox(
                  width: width,
                  child: Link(
                    uri: Uri.parse('mailto:info@greenseattle.org'),
                    builder: (context, followLink) => GestureDetector(
                      onTap: followLink,
                      child: const Text(
                        'info@greenseattle.org',
                        style: TextStyle(
                            fontSize: 17,
                            height: 1.2,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: Link(
                    uri: Uri.parse(
                        'https://greenseattle.org/get-involved/volunteer/'),
                    builder: (context, followLink) => GestureDetector(
                      onTap: followLink,
                      child: const Text(
                        'Volunteering with the Green Seattle Partnership',
                        style: TextStyle(
                            fontSize: 17,
                            height: 1.2,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: Link(
                    uri: Uri.parse(
                        'https://seattle.greencitypartnerships.org/event/map/'),
                    builder: (context, followLink) => GestureDetector(
                      onTap: followLink,
                      child: const Text(
                        'Events Calendar',
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17,
                            height: 1.2,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
