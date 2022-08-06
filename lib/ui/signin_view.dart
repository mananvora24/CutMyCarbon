import 'package:flutter/material.dart';
import 'package:cut_my_carbon/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
            /*appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: const Color.fromARGB(255, 119, 188, 63),
              elevation: 0,
            ),*/
            backgroundColor: const Color.fromARGB(255, 119, 188, 63),
            body: Center(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                  alignment: Alignment.topRight,
                ),
                const Text('Enter your username',
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
                    controller: usernameController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'username',
                    ),
                  ),
                ),
              ]),
            ),
            persistentFooterButtons: [
              SizedBox(height: height * 0.04),
              ElevatedButton(
                onPressed: () {
                  var username = int.parse(usernameController.text);
                  model.submitTipsData('user1234', username);
                  print(username);
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
            ]),
      ),
    );
  }
}
