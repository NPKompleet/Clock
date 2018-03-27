import 'package:flutter/material.dart';
import 'package:clock/clock_dial_painter.dart';
import 'package:clock/clock_hands.dart';

class ClockFace extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new AspectRatio(
        aspectRatio: 1.0,
        child: new Container(
          width: double.INFINITY,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),

          child: new Stack(
            children: <Widget>[
              //dial and numbers
              new Container(
                width: double.INFINITY,
                height: double.INFINITY,
                padding: const EdgeInsets.all(10.0),
                child:new CustomPaint(
                  painter: new ClockDialPainter(),
                ),
              ),


              //centerpoint
              new Center(
                child: new Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),


              new ClockHands(),

            ],
          ),
        ),

      ),
    );
  }
}


