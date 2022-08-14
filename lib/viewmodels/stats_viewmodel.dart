import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class StatsViewModel extends SharedViewModel {
  StatsViewModel();

  Future<Map<String, dynamic>> getUserStatistics(String user) async {
    List<dynamic> dataList = List.empty();
    Map<String, dynamic> currentUserStatistics = {};
    await FirebaseFirestore.instance
        .collection('UserStatistics')
        .where('user', isEqualTo: user)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      dataList = querySnapshot.docs;
      if (dataList.isEmpty) {
        print("getUserStatistics: Data is empty");
      } else {
        print("getCurrentTip: Data Found");
      }
      for (var snapshot in dataList) {
        currentUserStatistics = snapshot.data();
        break;
      }
    });
    return currentUserStatistics;
  }
}
