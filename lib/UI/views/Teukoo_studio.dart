import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/shared/bottom_nav_bar.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/colors.dart';

class Notifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Teukoo Studio"),),
      backgroundColor: MyColor.primaryBackground,
      bottomNavigationBar: AppBottomNav(),
    );
  }
}