import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class ClockHands extends StatefulWidget {
  ClockHands();

  @override
  _ClockHandsState createState() => new _ClockHandsState();
}

class _ClockHandsState extends State<ClockHands> {
  DateTime _dateTime;
  Timer _timer;




  @override
  void initState() {
    super.initState();
    _dateTime=new DateTime.now();
    _timer= new Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer){
    setState((){
      _dateTime= new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        //hour hand
        new Container(
          width: double.INFINITY,
          height: double.INFINITY,
          padding: const EdgeInsets.all(20.0),
          child:new CustomPaint(
            painter: new HourHandPainter(
                hours: _dateTime.hour,
                minutes: _dateTime.minute
            ),
          ),
        ),

        //minute hand
        new Container(
          width: double.INFINITY,
          height: double.INFINITY,
          padding: const EdgeInsets.all(20.0),
          child:new CustomPaint(
            painter: new MinuteHandPainter(
              minutes: _dateTime.minute,
              seconds: _dateTime.second,
            ),
          ),
        ),

        //second hand
        new Container(
          width: double.INFINITY,
          height: double.INFINITY,
          padding: const EdgeInsets.all(20.0),
          child:new CustomPaint(
            painter: new SecondHandPainter(seconds: _dateTime.second),
          ),
        ),

      ],
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
    return (((oldDelegate.seconds-this.seconds).abs()>= 6) || (this.minutes!=oldDelegate.minutes));
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
    return (((oldDelegate.minutes-this.minutes).abs() >= 6) || (oldDelegate.hours != this.hours));
  }
}
