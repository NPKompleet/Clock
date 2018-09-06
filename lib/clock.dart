import 'dart:math';

import 'package:clock/clock_text.dart';
import 'package:flutter/material.dart';
import 'package:clock/clock_face.dart';

class Clock extends StatelessWidget {

  final Color circleColor;
  final bool showBellsAndLegs;
  final Color bellColor;
  final Color legColor;
  final ClockText clockText;
  final bool showHourHandleHeartShape;

  Clock({this.circleColor = Colors.black,
         this.showBellsAndLegs = true,
         this.bellColor = const Color(0xFF333333),
         this.legColor = const Color(0xFF555555),
         this.clockText = ClockText.arabic,
         this.showHourHandleHeartShape = false
  });

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
        aspectRatio: 1.0,
        child: (showBellsAndLegs)? new Stack(
            children: <Widget>[
              new Container(
                width: double.infinity,
                child: new CustomPaint(
                  painter: new BellsAndLegsPainter(bellColor: bellColor, legColor: legColor),
                ),
              ),

              buildClockCircle(context)
            ]
        ) : buildClockCircle(context),

    );
  }

  Container buildClockCircle(BuildContext context) {
    return new Container(
              width: double.infinity,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                boxShadow: [
                  new BoxShadow(
                    offset: new Offset(0.0, 5.0),
                    blurRadius: 5.0,
                  )
                ],
              ),

              child: new ClockFace(
                  clockText : clockText,
                  showHourHandleHeartShape: showHourHandleHeartShape
              ),

            );
  }
}

class BellsAndLegsPainter extends CustomPainter{
  final Color bellColor;
  final Color legColor;
  final Paint bellPaint;
  final Paint legPaint;

  BellsAndLegsPainter({this.bellColor = const Color(0xFF333333), this.legColor = const Color(0xFF555555)}):
      bellPaint= new Paint(),
      legPaint= new Paint() {
      bellPaint.color= bellColor;
      bellPaint.style= PaintingStyle.fill;

    legPaint.color= legColor;
    legPaint.style= PaintingStyle.stroke;
    legPaint.strokeWidth= 10.0;
    legPaint.strokeCap= StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    //draw the handle
    Path path = new Path();
    path.moveTo(-60.0, -radius-10);
    path.lineTo(-50.0, -radius-50);
    path.lineTo(50.0, -radius-50);
    path.lineTo(60.0, -radius-10);

    canvas.drawPath(path, legPaint);

    //draw right bell and left leg
    canvas.rotate(2*pi/12);
    drawBellAndLeg(radius, canvas);

    //draw left bell and right leg
    canvas.rotate(-4*pi/12);
    drawBellAndLeg(radius, canvas);

    canvas.restore();

  }

  //helps draw the leg and bell
  void drawBellAndLeg(radius, canvas){
    //bell
    Path path1 = new Path();
    path1.moveTo(-55.0, -radius-5);
    path1.lineTo(55.0, -radius-5);
    path1.quadraticBezierTo(0.0, -radius-75, -55.0, -radius-10);

    //leg
    Path path2= new Path();
    path2.addOval(new Rect.fromCircle(center: new Offset(0.0, -radius-50), radius: 3.0));
    path2.moveTo(0.0, -radius-50);
    path2.lineTo(0.0, radius+20);

    //draw the bell on top on the leg
    canvas.drawPath(path2, legPaint);
    canvas.drawPath(path1, bellPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
