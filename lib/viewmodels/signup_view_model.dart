import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/services/analytics_service.dart';
import 'package:teukoo/services/authentication_service.dart';
import 'package:teukoo/services/dialog_service.dart';
import 'package:teukoo/services/navigation_service.dart';
import 'package:flutter/foundation.dart';
import '../service_locator.dart';
import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

    int _selectedage ;
  int get selectedage => _selectedage;

  void setSelectedage(dynamic age) {
    _selectedage = age;
    notifyListeners();
  }

  Future signUp({
    @required String email,
    @required String password,
   
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      role: _selectedage,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        await _analyticsService.logSignUp();
        _navigationService.navigateTo(ProfileSettingsRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }

  void navigateToLogin() {
    _navigationService.navigateTo(LoginViewRoute);
  }
}
