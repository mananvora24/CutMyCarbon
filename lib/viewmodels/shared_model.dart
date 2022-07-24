import 'package:cut_my_carbon/core/utilities/route_names.dart';
import 'package:cut_my_carbon/viewmodels/base_viewmodel.dart';
import 'package:cut_my_carbon/core/enums/view_state.dart';
import 'package:cut_my_carbon/locator.dart';
import 'package:cut_my_carbon/core/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';

class SharedViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  SharedViewModel() {
    setState(ViewState.Busy);
    try {
      _initMethod();
    } catch (e) {
      setState(ViewState.Error);
    }
    setState(ViewState.Idle);
  }

  void _initMethod() {}

  void routeToHomeView() {
    _navigationService.navigateTo(HomeViewRoute);
  }

  void routeToTipsView() {
    _navigationService.navigateTo(TipsViewRoute);
  }

  void routeToStatsView() {
    _navigationService.navigateTo(StatsViewRoute);
  }

  void routeToAboutForterraView() {
    _navigationService.navigateTo(AboutForterraViewRoute);
  }

  void routeToAboutUSView() {
    _navigationService.navigateTo(AboutUsViewRoute);
  }
}
