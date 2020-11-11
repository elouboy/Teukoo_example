import 'package:teukoo_code/UI/views/camera.dart';
import 'package:teukoo_code/UI/views/edit_profile.dart';
import 'package:teukoo_code/UI/views/home.dart';
import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/views/Teukoo_studio.dart';
import 'package:teukoo_code/UI/views/preview_screen.dart';
import 'package:teukoo_code/UI/views/profile.dart';
import 'package:teukoo_code/UI/views/profile_creation.dart';
import 'package:teukoo_code/UI/views/search.dart';
import 'package:teukoo_code/UI/views/settings.dart';
import 'package:teukoo_code/UI/views/settings_screens/Terms_&_conditions.dart';
import 'package:teukoo_code/UI/views/settings_screens/about_us.dart';
import 'package:teukoo_code/UI/views/settings_screens/privacy_policy.dart';
import 'package:teukoo_code/UI/views/video_preview.dart';
import 'package:teukoo_code/constants/route_names.dart';
import 'package:teukoo_code/UI/views/login.dart';
import 'package:teukoo_code/UI/views/signUp.dart';
import 'package:teukoo_code/models/user.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Login(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUP(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case AboutRoute:
      return _getPageRoute(
           routeName: settings.name,
           viewToShow: About(),
      );
    case PrivateRoute:
      return _getPageRoute(
           routeName: settings.name,
           viewToShow: Private(),
      );
    case TermsRoute:
      return _getPageRoute(
           routeName: settings.name,
           viewToShow: Terms(),
      );
    case SettingsRoute:
      return _getPageRoute(
        routeName:settings.name,
        viewToShow:Settings(),
      );
      case ProfileRoute:
      String id;
      id = settings.arguments;
      return _getPageRoute(
        routeName:settings.name,
        viewToShow: Profile(
          id: id,
        ),
      );
      case SearchRoute:
      return _getPageRoute(
        routeName:settings.name,
        viewToShow: Search(),
      );
      case NotificationsRoute:
      return _getPageRoute(
        routeName:settings.name,
        viewToShow: Notifications(),
      );
      case CameraRoute:
      return _getPageRoute(
        routeName:settings.name,
        viewToShow: Camera(),
      );
      case PreviewScreenRoute:
      String imagePath;
      imagePath = settings.arguments;
      return _getPageRoute(
        routeName:settings.name,
        viewToShow:PreviewImageScreen(
          imagePath: imagePath,
        ),
      );
      case VideoPreviewRoute:
      String videoFile;
      videoFile = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow:VideoPreview(
          videoFile: videoFile,
        ),
      );
      case ProfileSettingsRoute:
      
      Users user;
      user = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProfileSettings(user)
      );
      case EditProfileRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: EditProfile()
      );
      
      

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}