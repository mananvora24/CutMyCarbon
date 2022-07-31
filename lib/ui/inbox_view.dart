import 'package:flutter/material.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class InboxView extends StatelessWidget {
  const InboxView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
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
            /*title: Text(category,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25.0)),*/
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '1',
                  ),
                ),
              ),
              SizedBox(
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
