import 'package:flutter/material.dart';

class CalendarHandler extends StatefulWidget {
  const CalendarHandler({
    super.key,
    required this.calendarPadding,
    required this.monthList,
    required this.currentPageIndex,
    required this.updateCurrentPageIndex,
  });

  final double calendarPadding;

  final List<int> monthList;
  final int currentPageIndex;

  final void Function(int) updateCurrentPageIndex;

  @override
  State<CalendarHandler> createState() => _CalendarHandlerState();
}

class _CalendarHandlerState extends State<CalendarHandler> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.calendarPadding > 10
              ? widget.calendarPadding - 10
              : widget.calendarPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.currentPageIndex > 0) {
                widget.updateCurrentPageIndex(widget.currentPageIndex - 1);
              }
            },
            child: SizedBox(
              width: 32,
              height: 38,
              child: Image.asset(
                'images/btn_cal_left.png',
                width: 12,
                height: 18,
              ),
            ),
          ),
          Text(
            '${widget.monthList[widget.currentPageIndex]}월',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              color: Color(0xFF4A4A4A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.currentPageIndex < widget.monthList.length) {
                widget.updateCurrentPageIndex(widget.currentPageIndex + 1);
              }
            },
            child: SizedBox(
              width: 32,
              height: 38,
              child: Image.asset(
                'images/btn_cal_right.png',
                width: 12,
                height: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
