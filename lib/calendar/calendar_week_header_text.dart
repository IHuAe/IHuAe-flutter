import 'package:flutter/material.dart';

class CalendarWeekHeaderText extends StatelessWidget {
  const CalendarWeekHeaderText({
    super.key,
    required this.weekText,
    required this.widthSize,
  });
  final String weekText;
  final double widthSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      alignment: Alignment.center,
      child: Text(
        weekText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'SpoqaHanSansNeo',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
