import 'dart:async';
import 'dart:math';

import 'package:clock/clock_hands.dart';
import 'package:flutter/material.dart';


class MinuteHand extends StatefulWidget {
  final int minute;
  final int second;

  MinuteHand({this.minute, this.second});

  @override
  _MinuteHandState createState() => new _MinuteHandState();
}

class _MinuteHandState extends State<MinuteHand> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    //ClockHand.dateTime= new DateTime.now();
    _timer= new Timer.periodic(const Duration(seconds: 6), setMinute);
  }

  void setMinute(Timer timer){
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
        painter: new MinuteHandPainter(
          minutes: ClockHands.dateTime.minute,
          seconds: ClockHands.dateTime.second,
        ),
      ),
    );
  }
}



class MinuteHandPainter extends CustomPainter{
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({this.minutes, this.seconds}):minuteHandPaint= new Paint(){
    minuteHandPaint.color= const Color(0xFF333333);
    minuteHandPaint.style= PaintingStyle.fill;

  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius= size.width/2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2*PI*((this.minutes+(this.seconds/60))/60));

    Path path= new Path();
    path.moveTo(-1.5, -radius-10.0);
    path.lineTo(-5.0, -radius/1.8);
    path.lineTo(-2.0, 10.0);
    path.lineTo(2.0, 10.0);
    path.lineTo(5.0, -radius/1.8);
    path.lineTo(1.5, -radius-10.0);
    path.close();

    canvas.drawPath(path, minuteHandPaint);
    canvas.drawShadow(path, Colors.black, 4.0, false);


    canvas.restore();

  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
