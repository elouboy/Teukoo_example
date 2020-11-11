import 'package:teukoo_code/constants/route_names.dart';
import 'package:teukoo_code/services/authentication_service.dart';
import 'package:teukoo_code/services/navigation_service.dart';
import 'package:teukoo_code/services/push_notification_service.dart';
import 'package:teukoo_code/viewmodels/base_model.dart';
import '../service_locator.dart';

class StartViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}