import 'package:flutter/material.dart';

class MyGradients extends BoxDecoration{

static final FractionalOffset begin = FractionalOffset(0.0,0.0);
static final FractionalOffset endHorizontal = FractionalOffset(1.0,0.0);
static final FractionalOffset endVertical = FractionalOffset(0.0,1.0);

  MyGradients ({
    @required Color startColor,
    @required Color endColor,
    bool horizontal: false,
     @required double radius,
  }) : super (
    gradient: LinearGradient(
      colors: [startColor,endColor],
      begin: begin,
      end: (horizontal) ? endHorizontal : endVertical,
      tileMode: TileMode.clamp,
    ),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
}