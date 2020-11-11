import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teukoo/UI/shared/ui_helpers.dart';
import 'package:teukoo/UI/widgets/my_material.dart';

class Participate extends StatefulWidget {
  Participate({Key key}) : super(key: key);

  @override
  _ParticipateState createState() => _ParticipateState();
}

class _ParticipateState extends State<Participate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: MyColor.primaryBackground,
       body: SafeArea(
         child: Container(
           child: Column(
             children: [
               Expanded(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   DropdownButton(
                     items: null, 
                     onChanged: null
                     ),
                   Row(
                     children: [
                       Icon(Icons.hourglass_full, color: Color(0xFFFFFFFF)),
                       Text(''),
                     ]
                   ) ,
                   verticalSpaceMedium,
                   Expanded(
                     child: Stack(
                     textDirection: TextDirection.rtl,
                     fit: StackFit.loose,
                     alignment: Alignment.center,
                     children: [
                          Positioned(
                            left:0,
                            right: 0,
                            top: 0,
                            bottom:0,
                            child: Container(
                              height: 465,
                              width: 330,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                              ),
                              child: Image.asset(
                          'assets/logoImage.png',
                          fit: BoxFit.fill,
                        ), 
                            )
                            ),
                            Positioned(
                              bottom: -50,
                              left: 0,
                              right:0,
                              child: Container(
                                height: 165,
                                width: 275,
                                decoration: BoxDecoration(
                                  color: MyColor.containerChallenge,
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.card_giftcard, color: Color(0xFFFFFFFF),),
                                        Text('null'),

                                      ],),
                                      Text('null'),
                                      Container(
                                        height: 40,
                                        width: 125,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20.5))
                                        ),
                                        child: OutlineButton(
                                          child: Text('Subscribe', style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                          )),
                                          shape:  RoundedRectangleBorder(
                                            side: BorderSide(
                                            color: Color(0xFFFFFFFF)),
                                            borderRadius:  BorderRadius.circular(30.0)),
                                          onPressed: null)
                                      )
                                  ],
                                ),

                              ))
                     ],
                   ),
                   ),
                 ],)
               ),
             ],)
         )),
    );
  }
}