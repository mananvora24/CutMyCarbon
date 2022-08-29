import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class AcceptTermsViewModel extends SharedViewModel {
  AcceptTermsViewModel();

  Future<void> getUsername(String email) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userEmail', isEqualTo: email)
        .set()
  }
    

  
}
