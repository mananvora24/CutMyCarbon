import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class TipSelectedViewModel extends SharedViewModel {
  TipSelectedViewModel();
  String fact = "";
  Map<String, dynamic>? factsData = {};

  Future<String> getCategoryFact(String category) async {
    await FirebaseFirestore.instance
        .collection('CategoryFacts')
        .where('Category', isEqualTo: category)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      for (var snapshot in data) {
        factsData = snapshot.data();
        factsData?.forEach((key, value) {
          fact = factsData!["Fact"];
        });
      }
    });
    return fact;
  }
}
