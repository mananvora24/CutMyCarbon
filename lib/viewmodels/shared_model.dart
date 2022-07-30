import 'package:cut_my_carbon/core/utilities/route_names.dart';
import 'package:cut_my_carbon/viewmodels/base_viewmodel.dart';
import 'package:cut_my_carbon/core/enums/view_state.dart';
import 'package:cut_my_carbon/locator.dart';
import 'package:cut_my_carbon/core/services/navigation_service.dart';

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
    _navigationService.navigateTo(homeViewRoute);
  }

  void routeToTipsView(String category) {
    _navigationService.navigateTo(tipsViewRoute, arguments: category);
  }

  void routeToTipCategoriesView() {
    _navigationService.navigateTo(tipCategoriesViewRoute);
  }

  void routeToStatsView() {
    _navigationService.navigateTo(statsViewRoute);
  }

  void routeToAboutForterraView() {
    _navigationService.navigateTo(aboutForterraViewRoute);
  }

  void routeToAboutUSView() {
    _navigationService.navigateTo(aboutUsViewRoute);
  }

  void routeToTipSelectedView(String category, String tip) {
    _navigationService.navigateTo(
      tipSelectedViewRoute,
      arguments: category,
    );
  }

  void routeToTipStatusUpdateView() {
    _navigationService.navigateTo(tipStatusUpdateViewRoute);
  }
}
