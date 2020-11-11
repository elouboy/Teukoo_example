import 'package:get_it/get_it.dart';
import 'package:teukoo_code/services/algolia_service.dart';
import 'package:teukoo_code/services/cloud_storage_service.dart';
import 'package:teukoo_code/services/firestore_service.dart';
import 'package:teukoo_code/services/push_notification_service.dart';
import 'package:teukoo_code/services/string_templateService.dart';
import 'package:teukoo_code/utils/image_selector.dart';
import 'services/authentication_service.dart';
import 'services/analytics_service.dart';
import 'services/dialog_service.dart';
import 'services/navigation_service.dart';


GetIt locator = GetIt();

void setupLocator() {
  
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => AlgoliaService());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => StringTemplateService());
  
  

}