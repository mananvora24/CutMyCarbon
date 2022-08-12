import 'package:flutter/material.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class TipStatusUpdateView extends StatelessWidget {
  const TipStatusUpdateView({
    Key? key,
    required this.user,
    required this.category,
    required this.tipOrder,
  }) : super(key: key);
  final String user;
  final String category;
  final int tipOrder;

  @override
  Widget build(BuildContext context) {
    TextEditingController daysController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
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
          body: Center(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                alignment: Alignment.topRight,
              ),
              const Text('Enter the number of days you completed the activity',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: daysController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '1',
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    var days = int.parse(daysController.text);
                    model.submitTipsData('user1234', category, tipOrder, days);
                    print(days);
                    model.routeToTipStatusResultView(
                        user, category, tipOrder, days);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(170, 30),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
