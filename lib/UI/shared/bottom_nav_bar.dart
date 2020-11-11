import 'package:flutter/material.dart';
import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/authentication_service.dart';
import 'package:teukoo/services/navigation_service.dart';

import "package:teukoo/ui/widgets/my_material.dart";

class AppBottomNav extends StatefulWidget {
@override
  _AppBottomNavState createState() => _AppBottomNavState();
}
int _currentIndex = 0;

class _AppBottomNavState extends State<AppBottomNav>{

final NavigationService _navigationService = locator<NavigationService>();
final AuthenticationService _authenticationService =
      locator<AuthenticationService>();


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: MyColor.bottomBarcolor,
      type: BottomNavigationBarType.fixed,
      elevation: 40,
      
      items: [
        BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.home__1_, size: 20, color: MyColor.colorEditProfile,),
            title: Text('Home', style: TextStyle(color: _currentIndex == 0 ? MyColor.nextCamera : MyColor.colorEditProfile),),
            activeIcon: Icon(MyFlutterApp.home__1_, size: 20, color: MyColor.nextCamera),
            ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 20,color: MyColor.colorEditProfile,),
            title: Text('search', style: TextStyle(color: _currentIndex == 1 ? MyColor.nextCamera : MyColor.colorEditProfile),),
            activeIcon: Icon(Icons.search, size: 20,color: MyColor.nextCamera,),
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera, size: 20, color: MyColor.colorEditProfile,),
            title: Text('camera', style: TextStyle(color: _currentIndex == 2 ? MyColor.nextCamera : MyColor.colorEditProfile),),
            activeIcon: Icon(Icons.photo_camera, size: 20, color: MyColor.nextCamera,),
            ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications, size: 20, color: MyColor.colorEditProfile,),
            title: Text('Studio', style: TextStyle(color: _currentIndex == 3 ? MyColor.nextCamera : MyColor.colorEditProfile),),
            activeIcon: Icon(Icons.notifications, size: 20, color: MyColor.nextCamera,),
            ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 20, color: MyColor.colorEditProfile,),
            title: Text('profile',style: TextStyle(color: _currentIndex == 4 ? MyColor.nextCamera : MyColor.colorEditProfile),),
            activeIcon: Icon(Icons.person, size: 20, color: MyColor.nextCamera,),
            ),
      ],
      unselectedItemColor: MyColor.colorEditProfile,
      selectedItemColor: MyColor.nextCamera,
      currentIndex: _currentIndex,
      onTap: (int idx) {
        setState(() {
          _currentIndex = idx;
            });
             switch (_currentIndex) {
              case 0:
              _navigationService.navigateTo(HomeViewRoute);
              

                break;
              case 1:
               _navigationService.navigateTo(SearchRoute);
               

                break;
              case 2:
               _navigationService.navigateTo(CameraRoute);
               

                break;
              case 3:
               _navigationService.navigateTo(NotificationsRoute);
               

                break;
              case 4:
               _navigationService.navigateTo(ProfileRoute, arguments:_authenticationService.currentUser.id );
              

               break;
        }
        
        },
      
        );
    
        
      }
    
  }
