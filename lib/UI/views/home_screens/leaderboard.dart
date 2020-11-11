import 'package:flutter/material.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo/services/Api_service/api_client.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({Key key}) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: MyColor.primaryBackground,
       body: Container(
         child: Center(
           child:RaisedButton(onPressed:() { getChallengesForSubs();
           print('a');}),
       ),
       ),
    );
  }
}