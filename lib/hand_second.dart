import 'dart:async';
import 'dart:math';

import 'package:clock/clock_hands.dart';
import 'package:flutter/material.dart';

class SecondHand extends StatefulWidget {
  final int second;

  SecondHand({this.second});

  @override
  _SecondHandState createState() => new _SecondHandState();
}

class _SecondHandState extends State<SecondHand> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    //ClockHand.dateTime= new DateTime.now();
    _timer= new Timer.periodic(const Duration(seconds: 1), setSecond);
  }

  void setSecond(Timer timer){
    setState((){
      ClockHands.dateTime= new DateTime.now();
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
        painter: new SecondHandPainter(seconds: ClockHands.dateTime.second),
      ),
    );
  }
}


class SecondHandPainter extends CustomPainter{
  final Paint secondHandPaint;
  final Paint secondHandPointsPaint;

  int seconds;

  SecondHandPainter({this.seconds}):
        secondHandPaint= new Paint(),
        secondHandPointsPaint= new Paint(){
    secondHandPaint.color= Colors.red;
    secondHandPaint.style= PaintingStyle.stroke;
    secondHandPaint.strokeWidth= 2.0;

    secondHandPointsPaint.color=Colors.red;
    secondHandPointsPaint.style= PaintingStyle.fill;

  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius= size.width/2;
    canvas.save();

    canvas.translate(radius, radius);


    canvas.rotate(2*PI*this.seconds/60);

    Path path1= new Path();
    Path path2 = new Path();
    path1.moveTo(0.0, -radius );
    path1.lineTo(0.0, radius/4);

    path2.addOval(new Rect.fromCircle(radius: 7.0, center: new Offset(0.0, -radius)));
    path2.addOval(new Rect.fromCircle(radius: 5.0, center: new Offset(0.0, 0.0)));




    canvas.drawPath(path1, secondHandPaint);
    canvas.drawPath(path2, secondHandPointsPaint);


    canvas.restore();
  }

  @override
  bool shouldRepaint(SecondHandPainter oldDelegate) {
    return this.seconds != oldDelegate.seconds;
  }
}