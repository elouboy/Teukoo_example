import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/shared/bottom_nav_bar.dart';
import 'package:teukoo_code/UI/shared/ui_helpers.dart';
import 'package:teukoo_code/UI/widgets/my_material.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo_code/services/authentication_service.dart';
import 'package:teukoo_code/services/navigation_service.dart';
import 'package:teukoo_code/constants/route_names.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service_locator.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);


  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
final NavigationService _navigationService = locator<NavigationService>();
final AuthenticationService _authenticationService =locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.bottomBarcolor,
        title: Text("Settings", style: TextStyle(color: Color(0xFFFFFFFF))),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: _navigationService.pop,
        ),
      ),
      bottomNavigationBar:  AppBottomNav(
      ),
      backgroundColor: MyColor.primaryBackground,
      body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          verticalSpaceMedium,
    
           getListView(),
          verticalSpaceMedium,
          Padding(
          padding:EdgeInsets.only(left:20),
          child:Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [MyColor.nextCamera, MyColor.closeCamera]),
                shape: BoxShape.circle,
                ),
                  child: IconButton(
                    icon: Icon(
                          Icons.power_settings_new,
                          color: Color(0xFFFFFFFF), ),
                    onPressed: _authenticationService.signOut,
                  
                    
                ),
                ),
                
                Text(" Logout",
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
                ),
              
            ],
          ),
          ),
        ],
      ),
      
      ),
    );
  }
}

void _createEmail() async {
  const emailaddress = 'mailto:contact@teukoo.com';
  if (await canLaunch(emailaddress)) {
    await launch(emailaddress);
  } else {
    throw 'Could not Email';
  }
}

Widget getListView() {
  final NavigationService _navigationService = locator<NavigationService>();
  var listView = ListView(
    shrinkWrap: true,
    children: <Widget>[
      ListTile(
        leading: ClipOval(
          child: Material(
            color: Color(0xFF313947), // button color
            child: SizedBox(
                width: 56, height: 56, child: Icon(Icons.info_outline, color:  Color(0xFFFFFFFF),)),
          ),
        ),
        title: Text("About Us", style: TextStyle(color: Color(0xFFFFFFFF)),),
        trailing: Icon(Icons.navigate_next, color: Color(0xFFFFFFFF),),
        onTap: () {
          _navigationService.navigateTo(AboutRoute);
        },
      ),
      Divider(
        color: Color(0xFFFFFFFF),
      ),
      ListTile(
        leading: ClipOval(
          child: Material(
            color: Color(0xFF313947), // button color
            child: SizedBox(
                width: 56, height: 56, child: Icon(Icons.priority_high, color: Color(0xFFFFFFFF),)),
          ),
        ),
        title: Text("Privacy Policy", style: TextStyle(color: Color(0xFFFFFFFF))),
        trailing: Icon(Icons.navigate_next, color: Color(0xFFFFFFFF)),
        onTap: () {
          _navigationService.navigateTo(PrivateRoute);
        },
      ),
      Divider(
        color: Color(0xFFFFFFFF),
      ),
      ListTile(
        leading: ClipOval(
          child: Material(
            color: Color(0xFF313947), // button color
            child:
                SizedBox(width: 56, height: 56, child: Icon(Icons.description, color: Color(0xFFFFFFFF),)),
          ),
        ),
        title: Text("Terms & Conditions",style: TextStyle(color: Color(0xFFFFFFFF))),
        trailing: Icon(Icons.navigate_next, color: Color(0xFFFFFFFF),),
        onTap: () {
          _navigationService.navigateTo(TermsRoute);
        },
      ),
      Divider(
        color: Color(0xFFFFFFFF),
      ),
      ListTile(
        leading: ClipOval(
          child: Material(
            color: Color(0xFF313947), // button color
            child: SizedBox(
                width: 56, height: 56, child: Icon(Icons.help_outline,color:  Color(0xFFFFFFFF),)),
          ),
        ),
        title: Text("Help",style: TextStyle(color: Color(0xFFFFFFFF))),
        trailing: Icon(Icons.navigate_next, color: Color(0xFFFFFFFF),),
        onTap: () {
          _createEmail();
        },
      ),
      Divider(
        color: Color(0xFFFFFFFF),
      ),
    ],
  );

  return listView;
}
