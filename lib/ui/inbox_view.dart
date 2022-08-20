import 'package:cut_my_carbon/viewmodels/mail_content.dart';
import 'package:cut_my_carbon/viewmodels/mail_generator.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class InboxView extends StatefulWidget {
  const InboxView({Key? key}) : super(key: key);

  @override
  _InboxViewState createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<MailContent> mailList = [];

    return ChangeNotifierProvider(
      create: (context) => MailGenerator(),
      child: Consumer<MailGenerator>(
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
          body: Column(children: [
            SizedBox(
              height: height * 0.8,
              child: FutureBuilder<List<MailContent>>(
                  future: model.getMail(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<MailContent>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text(
                          'Error',
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        mailList = snapshot.data!;
                        print("Mails = ${mailList.length}");
                        print("Subject = ${mailList[0].subject}");
                        return ListView.builder(
                            itemCount: mailList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, position) {
                              MailContent mailContent = mailList[position];
                              return Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0,
                                      right: 14.0,
                                      top: 5.0,
                                      bottom: 5.0),
                                  child: Row(
                                    //crossAxisAlignment:
                                    //    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 0, 5),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    mailContent.subject,
                                                    style: const TextStyle(
                                                        fontFamily: primaryFont,
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 22.0),
                                                  ),
                                                  Text(
                                                    mailContent.time,
                                                    style: const TextStyle(
                                                        fontFamily: primaryFont,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: primaryColor,
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                          //fit: BoxFit.contain,
                                                          width: width * 0.9,
                                                          child: Text(
                                                            mailContent.message,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    primaryFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 20),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                              ]);
                            });
                      } else {
                        return const Text(
                          'Empty data',
                          style: TextStyle(
                            fontFamily: primaryFont,
                            color: primaryColor,
                          ),
                        );
                      }
                    } else {
                      return Text(
                        'State: ${snapshot.connectionState}',
                        style: const TextStyle(
                          fontFamily: primaryFont,
                          color: primaryColor,
                        ),
                      );
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
