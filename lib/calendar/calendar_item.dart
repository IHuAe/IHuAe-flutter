import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/services/emo_item.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
    required this.calendarData,
  });
  final double itemWidth;
  final double itemHeight;
  final CalendarData calendarData;

  @override
  Widget build(BuildContext context) {
    int calDay = calendarData.dateValue.day;
    bool isFirstDay = calDay == 1;
    bool isToday = false;
    if (calendarData.dateID ==
        int.parse(DateFormat('yyyyMMdd').format(DateTime.now()).toString())) {
      isToday = true;
    }
    return Container(
      width: itemWidth,
      height: itemHeight,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5.5),
      margin: EdgeInsets.only(
          left: (isFirstDay
              ? (calendarData.dateValue.weekday - 1) * itemWidth
              : 0)),
      child: Stack(children: [
        if (calendarData.todayEmo != 0)
          Center(
            child: Opacity(
              opacity: isToday ? 1.0 : 0.3,
              child: Image.asset(
                EmoItem(emoNo: calendarData.todayEmo).getEmoIconImage(),
              ),
            ),
          ),
        Center(
          child: Text(
            '$calDay',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
              fontSize: 12,
              color: isToday ? Color(0xFF2D2D2D) : Color(0xFF6D6D6D),
            ),
          ),
        ),
      ]),
    );
  }
}
