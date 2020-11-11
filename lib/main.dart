import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/views/start.dart';
import 'package:teukoo_code/services/analytics_service.dart';
import 'package:teukoo_code/services/navigation_service.dart';
import "package:teukoo_code/ui/widgets/my_material.dart";
import 'package:teukoo_code/UI/router.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'managers/dialog_manager.dart';
import 'service_locator.dart';
import 'services/dialog_service.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  setupLocator();
  return (runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Teukoo',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],
      theme: ThemeData(
        backgroundColor: MyColor.primaryBackground,
        primaryColor: MyColor.primaryElement,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: StartView(),
      onGenerateRoute: generateRoute,
    );
  }
}
