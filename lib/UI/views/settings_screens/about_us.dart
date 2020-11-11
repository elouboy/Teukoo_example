import 'package:flutter/material.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/navigation_service.dart';



class About extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryBackground,
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: _navigationService.pop,
        ),
        backgroundColor: MyColor.bottomBarcolor,
        title: Text("About Us", style: TextStyle(color: Color(0xFFFFFFFF))),
      ),
      body: AboutDialog(
      applicationName: "Teukoo",
      applicationVersion: "Bêta",
      applicationIcon:  SizedBox(
        child:Container(
        height: 100,
        decoration: BoxDecoration(color: MyColor.primaryBackground),
        child: Image.asset("assets/Logo_app.png"),

        ),
        ),
        
      ),
    );
  }
}