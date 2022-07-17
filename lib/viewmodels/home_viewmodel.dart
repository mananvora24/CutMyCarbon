import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/base_viewmodel.dart';
import 'package:cut_my_carbon/core/enums/view_state.dart';
import 'package:cut_my_carbon/locator.dart';
import 'package:cut_my_carbon/core/services/navigation_service.dart';
import 'package:cut_my_carbon/core/utilities/route_names.dart';

import '../models/Tip.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  HomeViewModel() {
    print("HomeViewModel Constructor Called()");
    setState(ViewState.Busy);
    try {
      _initMethod();
    } catch (e) {
      setState(ViewState.Error);
    }
    setState(ViewState.Idle);
  }

  void _initMethod() {
    for (int i = 0; i < 2; i++) {
      print(
          "HomeViewModel Init() function called printing $i iteration of my for loop");
    }
  }

  void routeToStatsView() {
    _navigationService.navigateTo(HomeViewRoute);
  }

  readTip() {
    Stream<List<Tip>> readTip() => FirebaseFirestore.instance
        .collection('Tips')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Tip.fromJson(doc.data())).toList());
  }
}
