import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soth_hak/controller/amount_controller.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RadialProgressCalories extends StatelessWidget {
  final double height, width;
  Color color;
  String text;
  int amount;
  int divider;
  RadialProgressCalories(
      {Key? key,

      required this.height,
      required this.width,
      required this.color,
      required this.text,
      required this.amount,
      required this.divider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final getController = Get.put(AmountController());
    return CustomPaint(
      painter: RadialPainter(progress: amount / divider, color: color),
      child: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() =>Text(
                getController.calories.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF200087),
                ),
              )),
              Text(
                text,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: color
                    // color:  Color(0xFF200087),
                    ),
              )
            ],
            
          ),
        ),
      ),
    );
  }
}
class RadialProgressProtein extends StatelessWidget {
  final double height, width;
  Color color;
  String text;
  int amount;
  int divider;
  RadialProgressProtein(
      {Key? key,

      required this.height,
      required this.width,
      required this.color,
      required this.text,
      required this.amount,
      required this.divider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final getController = Get.put(AmountController());
    return CustomPaint(
      painter: RadialPainter(progress: amount / divider, color: color),
      child: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() =>Text(
                getController.protein.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF200087),
                ),
              )),
              Text(
                text,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: color
                    // color:  Color(0xFF200087),
                    ),
              )
            ],
            
          ),
        ),
      ),
    );
  }
}
class RadialPainter extends CustomPainter {
  final double progress;
  final Color color;
  RadialPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class IngredientProgress extends StatelessWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const IngredientProgress(
      {Key? key,
      required this.ingredient,
      required this.leftAmount,
      required this.progress,
      required this.progressColor,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text("${leftAmount}g left"),
          ],
        ),
      ],
    );
  }
}
