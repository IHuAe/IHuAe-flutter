import 'package:flutter/material.dart';

import 'package:flutter_ihuae/calendar/calendar_week_header_text.dart';

class CalendarWeekHeaderContainer extends StatelessWidget {
  const CalendarWeekHeaderContainer({
    super.key,
    required double calendarPadding,
    required double itemWidth,
  })  : _calendarPadding = calendarPadding,
        _itemWidth = itemWidth;

  final double _calendarPadding;
  final double _itemWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _calendarPadding),
      child: Row(
        children: [
          CalendarWeekHeaderText(weekText: "월", widthSize: _itemWidth),
          CalendarWeekHeaderText(weekText: "화", widthSize: _itemWidth),
          CalendarWeekHeaderText(weekText: "수", widthSize: _itemWidth),
          CalendarWeekHeaderText(weekText: "목", widthSize: _itemWidth),
          CalendarWeekHeaderText(weekText: "금", widthSize: _itemWidth),
          CalendarWeekHeaderText(weekText: "토", widthSize: _itemWidth),
          CalendarWeekHeaderText(weekText: "일", widthSize: _itemWidth),
        ],
      ),
    );
  }
}
