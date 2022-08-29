import 'package:cut_my_carbon/viewmodels/accept_terms_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cut_my_carbon/core/utilities/constants.dart';

class AcceptTermsView extends StatelessWidget {
  const AcceptTermsView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => AcceptTermsViewModel(),
      child: Consumer<AcceptTermsViewModel>(
        builder: (context, model, child) => Theme(
          data: ThemeData().copyWith(
            dividerColor: Colors.transparent,
          ),
          child: Scaffold(
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
                title: const Text('Terms',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          padding: const EdgeInsets.all(9.0),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 15),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                      fontFamily: primaryFont,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23.0),
                                ),
                              ),
                              const Divider(
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: primaryFont,
                                    height: 2,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "These terms and conditions set forth the general terms and conditions of your use of the “Cut My Carbon” mobile application and any of its related products and services. This Agreement is legally binding between you and this Mobile Application developer. If you are entering into this agreement on behalf of a business or other legal entity, you represent that you have the authority to bind such an entity to this agreement, in which case the terms shall refer to such entity. If you do not have such authority, or if you do not agree with the terms of this agreement, you must not accept this agreement and may not access and use the Mobile Application and Services. By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Agreement. You acknowledge that this Agreement is a contract between you and the Operator, even though it is electronic and is not physically signed by you, and it governs your use of the Mobile Application and Services.",
                                  style: TextStyle(
                                    fontFamily: primaryFont,
                                    height: 1.3,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Accounts and Membership",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: primaryFont,
                                    height: 3,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "If you create an account in the Mobile Application, you are responsible for maintaining the security of your account and you are fully responsible for all activities that occur under the account and any other actions taken in connection with it. We may, but have no obligation to, monitor and review new accounts before you may sign in and start using the Services. Providing false contact information of any kind may result in the termination of your account. You must immediately notify us of any unauthorized uses of your account or any other breaches of security. We will not be liable for any acts or omissions by you, including any damages of any kind incurred as a result of such acts or omissions. We may suspend, disable, or delete your account (or any part thereof) if we determine that you have violated any provision of this Agreement or that your conduct or content would tend to damage our reputation and goodwill. If we delete your account for the foregoing reasons, you may not re-register for our Services. We may block your email address and Internet protocol address to prevent further registration.",
                                  style: TextStyle(
                                    fontFamily: primaryFont,
                                    height: 1.3,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Links to Other Resources",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 3,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Although the Mobile Application and Services may link to other resources (such as websites, mobile applications, etc.), we are not, directly or indirectly, implying any approval, association, sponsorship, endorsement, or affiliation with any linked resource, unless specifically stated herein. We are not responsible for examining or evaluating, and we do not warrant the offerings of any businesses or individuals or the content of their resources. We do not assume any responsibility or liability for the actions, products, services, and content of any other third parties. You should carefully review the legal statements and other conditions of use of any resource which you access through a link in the Mobile Application. Your linking to any other off-site resources is at your own risk.",
                                  style: TextStyle(
                                    fontFamily: primaryFont,
                                    height: 1.3,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Changes and Amendments",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: primaryFont,
                                    height: 3,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "We reserve the right to modify this Agreement or its terms related to the Mobile Application and Services at any time at our discretion. When we do, we will revise the updated date at the bottom of this page. We may also provide notice to you in other ways at our discretion, such as through the contact information you have provided.",
                                  style: TextStyle(
                                    height: 1.3,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "\nAn updated version of this Agreement will be effective immediately upon the posting of the revised Agreement unless otherwise specified. Your continued use of the Mobile Application and Services after the effective date of the revised Agreement (or such other act specified at that time) will constitute your consent to those changes.",
                                  style: TextStyle(
                                    height: 1.3,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Acceptance of These Terms",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 3,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "You acknowledge that you have read this Agreement and agree to all its terms and conditions. By accessing and using the Mobile Application and Services you agree to be bound by this Agreement. If you do not agree to abide by the terms of this Agreement, you are not authorized to access or use the Mobile Application and Services. This terms and conditions policy was created with the help of WebsitePolicies.com",
                                  style: TextStyle(
                                    height: 1.3,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Contact Us",
                                  style: TextStyle(
                                    height: 3,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "If you have any questions, concerns, or complaints regarding this Agreement, we encourage you to contact us using the details below:",
                                  style: TextStyle(
                                    height: 1.3,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "cutmycarbonhelp@gmail.com",
                                  style: TextStyle(
                                    height: 1.5,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "This document was last updated on August 26, 2022",
                                  style: TextStyle(
                                    height: 1.3,
                                    fontFamily: primaryFont,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ),
              persistentFooterButtons: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await model.saveAcceptedTerms();
                            model.routeToHomeView();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.all(10),
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                              color: whiteColor,
                              fontFamily: primaryFont,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
