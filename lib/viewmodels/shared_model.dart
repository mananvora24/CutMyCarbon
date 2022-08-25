import 'package:cloud_firestore/cloud_firestore.dart';
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

  void routeToTipsView(
      String user, String category, bool skip, int tipOverride, int tipMax) {
    _navigationService.navigateTo(tipsViewRoute, arguments: {
      'user': user,
      'category': category,
      'skip': skip,
      'tipOverride': tipOverride,
      'tipMax': tipMax
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

  void routeToTipSelectedView(String category, int tipOrder) {
    _navigationService.navigateTo(tipSelectedViewRoute,
        arguments: {'category': category, 'tipOrder': tipOrder});
  }

  void routeToTipShowCurrentView(
      String category, int tipOrder, Timestamp tipStartTime) {
    _navigationService.navigateTo(tipShowCurrentViewRoute, arguments: {
      'category': category,
      'tipOrder': tipOrder,
      'tipStartTime': tipStartTime,
    });
  }

  void routeToTipStatusUpdateView(String user, String category, int tipOrder,
      Timestamp tipStartTime, String message) {
    _navigationService.navigateTo(tipStatusUpdateViewRoute, arguments: {
      'user': user,
      'category': category,
      'tipOrder': tipOrder,
      'tipStartTime': tipStartTime,
      'message': message
    });
  }

  void routeToTipStatusResultView(String user, String category, int tipOrder,
      int days, Timestamp tipStartTime) {
    _navigationService.navigateTo(tipStatusResultsViewRoute, arguments: {
      'user': user,
      'category': category,
      'tipOrder': tipOrder,
      'days': days,
      'tipStartTime': tipStartTime,
    });
  }

  void routeToInboxView() {
    _navigationService.navigateTo(inboxViewRoute);
  }

  void routeToFeedbackView() {
    _navigationService.navigateTo(feedbackViewRoute);
  }

  void routeToFeedbackThanksView(
      String reason, String feedback, String message) {
    _navigationService.navigateTo(feedbackThanksViewRoute, arguments: {
      'reason': reason,
      'feedback': feedback,
      'message': message,
    });
  }

  void routeToSignInView() {
    _navigationService.navigateTo(signInViewRoute);
  }

  void routeToSettingsView() {
    _navigationService.navigateTo(settingsViewRoute);
  }

  void routeToAuthView() {
    _navigationService.navigateTo(authViewRoute);
  }

  void routeToSuggestATipView() {
    _navigationService.navigateTo(suggestATipViewRoute);
  }

  void routeToSuggestATipThanksView(
      String category, String tip, String message) {
    _navigationService.navigateTo(suggestATipThanksViewRoute, arguments: {
      'category': category,
      'tip': tip,
      'message': message,
    });
  }
}
