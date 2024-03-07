import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ihuae/title_bar.dart';

// 두번째 페이지
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double displaySize = MediaQuery.of(context).size.width;

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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
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
                ),
                SizedBox(height: 37),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeekHeaderText(weekText: "일", widthSize: displaySize / 7),
                    WeekHeaderText(weekText: "월", widthSize: displaySize / 7),
                    WeekHeaderText(weekText: "화", widthSize: displaySize / 7),
                    WeekHeaderText(weekText: "수", widthSize: displaySize / 7),
                    WeekHeaderText(weekText: "목", widthSize: displaySize / 7),
                    WeekHeaderText(weekText: "금", widthSize: displaySize / 7),
                    WeekHeaderText(weekText: "토", widthSize: displaySize / 7),
                  ],
                ),
                //SizedBox(height: 35),
                SizedBox(height: 19),
                Container(
                  height: 348,
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
                                    itemWidth: (displaySize / 7),
                                    itemHeight: 58,
                                  );
                                })),
                          ),
                        ],
                      );
                    },
                  ),
                ),
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
        ],
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
      decoration: BoxDecoration(
          color: Colors.amber, border: Border.all(color: Colors.white)),
      child: Stack(children: [
        Image.asset("images/ic_emotion_anger.png"),
        Center(
            child: Text(
          "30",
          style: TextStyle(
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF6D6D6D),
          ),
        ))
      ]),
    );
  }
}
