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
        currentUserStatistics['lastWeekCarbon'] = 0;
        currentUserStatistics['lastWeekPossibleCarbon'] = 0;
        currentUserStatistics['totalCarbon'] = 0;
        currentUserStatistics['totalPossibleCarbon'] = 0;
        currentUserStatistics['totalTons'] = 0;
        currentUserStatistics['user'] = user;
        currentUserStatistics['userID'] = 0;
      } else {
        for (var snapshot in dataList) {
          currentUserStatistics = snapshot.data();
          break;
        }
        print(
            "getUserStatistics: User is $user, Data Found $currentUserStatistics");
      }
    });
    return currentUserStatistics;
  }
}
