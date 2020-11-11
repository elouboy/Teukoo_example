import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/navigation_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _serialiseAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _serialiseAndNavigate(message);
      },
    );
  }


void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      //TODO Navigate to the create post view
      if (view == '') {
       // _navigationService.navigateTo();
      }
      // If there's no view it'll just open the app on the first view
    }
  }
}