import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ihuae/title_bar.dart';

// 두번째 페이지
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _displaySize = MediaQuery.of(context).size;
    double _displaySizeWidth = _displaySize.width;
    //double _displaySizeHeight = _displaySize.height;

    double _calendarPadding = 36;
    double _itemWidth = (_displaySizeWidth - _calendarPadding * 2) / 7;

    return Container(
      color: Color(0xFFF6F8Fd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                TitleBar(title: "캘린더"),
                SizedBox(height: 20),
                CalendarHandler(calendarPadding: _calendarPadding),
                SizedBox(height: 37),
                WeekHeaderContainer(
                    calendarPadding: _calendarPadding, itemWidth: _itemWidth),
                SizedBox(height: 19),
                CalendarContainer(itemWidth: _itemWidth),
                SizedBox(height: 19),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, bottom: 16),
            child: Text(
              '오늘의 기분',
              style: TextStyle(
                fontFamily: 'SpoqaHanSansNeo',
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A4A4A),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 27, left: 20, right: 20),
              padding: EdgeInsets.only(top: 25, bottom: 0, left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset("images/ic_emotion_calmness.png"),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "data",
                        style: TextStyle(
                          fontFamily: "SpoqaHanSansNeo",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 19),
                  Expanded(
                    child: Text(
                      "sldfskflsdkjfsl;dfjdsklfjsd;lkfjs;lkfjsl;fkjsd;lkfjsd;lkfjsl;kjfd;lskfj",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "SpoqaHanSansNeo",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarHandler extends StatelessWidget {
  const CalendarHandler({
    super.key,
    required double calendarPadding,
  }) : _calendarPadding = calendarPadding;

  final double _calendarPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _calendarPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/btn_cal_left.png',
            width: 12,
            height: 18,
          ),
          Text(
            '4월',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              color: Color(0xFF4A4A4A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Image.asset(
            'images/btn_cal_right.png',
            width: 12,
            height: 18,
          ),
        ],
      ),
    );
  }
}

class WeekHeaderContainer extends StatelessWidget {
  const WeekHeaderContainer({
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
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeekHeaderText(weekText: "일", widthSize: _itemWidth),
          WeekHeaderText(weekText: "월", widthSize: _itemWidth),
          WeekHeaderText(weekText: "화", widthSize: _itemWidth),
          WeekHeaderText(weekText: "수", widthSize: _itemWidth),
          WeekHeaderText(weekText: "목", widthSize: _itemWidth),
          WeekHeaderText(weekText: "금", widthSize: _itemWidth),
          WeekHeaderText(weekText: "토", widthSize: _itemWidth),
        ],
      ),
    );
  }
}

class CalendarContainer extends StatelessWidget {
  const CalendarContainer({
    super.key,
    required double itemWidth,
  }) : _itemWidth = itemWidth;

  final double _itemWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36),
      height: 340,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                height: 58,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((innerContext, innerIndex) {
                      return CalendarItem(
                        itemWidth: (_itemWidth),
                        itemHeight: 58,
                      );
                    })),
              ),
            ],
          );
        },
      ),
    );
  }
}

class WeekHeaderText extends StatelessWidget {
  const WeekHeaderText({
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

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
  });
  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemWidth,
      height: itemHeight,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5.5),
      //확인용
      // decoration: BoxDecoration(
      //     color: Colors.amber, border: Border.all(color: Colors.white)),
      child: Stack(children: [
        Center(
          child: Opacity(
            opacity: 0.3,
            child: Image.asset(
              "images/ic_emotion_dullness.png",
            ),
          ),
        ),
        Center(
          child: Text(
            "30",
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              //color: Color(0xFF6D6D6D), //TODO 오늘 외
              color: Color(0xFF2D2D2D), //TODO 오늘 날짜
            ),
          ),
        ),
      ]),
    );
  }
}
