import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:clock/clock_hands.dart';


class HourHand extends StatefulWidget {
  final int hour;
  final int minute;

  HourHand({this.hour, this.minute});

  @override
  _HourHandState createState() => new _HourHandState();
}

class _HourHandState extends State<HourHand> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    //ClockHand.dateTime= new DateTime.now();
    _timer= new Timer.periodic(const Duration(minutes: 6), setHour);
  }

  void setHour(Timer timer){
    setState((){
      //_dateTime= new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.INFINITY,
      height: double.INFINITY,
      padding: const EdgeInsets.all(20.0),
      child:new CustomPaint(
        painter: new HourHandPainter(
            hours: ClockHands.dateTime.hour,
            minutes: ClockHands.dateTime.minute
        ),
      ),
    );
  }
}




class HourHandPainter extends CustomPainter{
  final Paint hourHandPaint;
  int hours;
  int minutes;

  HourHandPainter({this.hours, this.minutes}):hourHandPaint= new Paint(){
    hourHandPaint.color= Colors.black87;
    hourHandPaint.style= PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width/2;
    // To draw hour hand
    canvas.save();

    canvas.translate(radius, radius);

    //checks if hour is greater than 12 before calculating rotation
    canvas.rotate(this.hours>=12?
    2*PI*((this.hours-12)/12 + (this.minutes/720)):
    2*PI*((this.hours/12)+ (this.minutes/720))
    );


    Path path= new Path();

    //heart shape head for the hour hand
    path.moveTo(0.0, -radius+15.0);
    path.quadraticBezierTo(-3.5, -radius + 25.0, -15.0, -radius+radius/4);
    path.quadraticBezierTo(-20.0, -radius+radius/3, -7.5, -radius+radius/3);
    path.lineTo(0.0, -radius+radius/4);
    path.lineTo(7.5, -radius+radius/3);
    path.quadraticBezierTo(20.0, -radius+radius/3, 15.0, -radius+radius/4);
    path.quadraticBezierTo(3.5, -radius + 25.0, 0.0, -radius+15.0);


    //hour hand stem
    path.moveTo(-1.0, -radius+radius/4);
    path.lineTo(-5.0, -radius+radius/2);
    path.lineTo(-2.0, 0.0);
    path.lineTo(2.0, 0.0);
    path.lineTo(5.0, -radius+radius/2);
    path.lineTo(1.0, -radius+radius/4);
    path.close();

    canvas.drawPath(path, hourHandPaint);
    canvas.drawShadow(path, Colors.black, 2.0, false);


    canvas.restore();

  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) {
    return true;
  }
}
