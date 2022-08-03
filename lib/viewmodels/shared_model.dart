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

  void routeToTipsView(String user, String category, int skipCount) {
    _navigationService.navigateTo(tipsViewRoute, arguments: {
      'user': user,
      'category': category,
      'skipCount': skipCount,
    });
  }

  void routeToTipCategoriesView(String user) {
    _navigationService.navigateTo(tipCategoriesViewRoute, arguments: user);
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
    _navigationService.navigateTo(tipSelectedViewRoute,
        arguments: {'category': category, 'tip': tip});
  }

  void routeToTipStatusUpdateView() {
    _navigationService.navigateTo(tipStatusUpdateViewRoute);
  }

  void routeToInboxView() {
    _navigationService.navigateTo(inboxViewRoute);
  }
}
