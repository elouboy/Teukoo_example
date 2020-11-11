import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/shared/bottom_nav_bar.dart';
import 'package:teukoo_code/UI/widgets/my_material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
   Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: MyColor.primaryBackground,
      body: Center(
        child: Text('Home')
      ),
      bottomNavigationBar: AppBottomNav(),
      ),
      );
      
    
  }
}