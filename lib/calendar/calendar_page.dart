//calender_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';

import '../chat/chat_page.dart';

// 두번째 페이지
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Title'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 49,
            padding: EdgeInsets.symmetric(horizontal: 9),
            decoration: BoxDecoration(
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
            child: Center(
              child: Text(
                'Your Title',
                style: TextStyle(
                  fontFamily: 'SpoqaHanSansNeoMedium',
                  color: Color(0xFF4A4A4A),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 28),
              padding: EdgeInsets.symmetric(horizontal: 60),
              decoration: BoxDecoration(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'images/btn_cal_left.png',
                    width: 32,
                    height: 38,
                  ),
                  Text(
                    '4월',
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeoBold',
                      color: Color(0xFF4A4A4A),
                      fontSize: 20,
                    ),
                  ),
                  Image.asset(
                    'images/btn_cal_right.png',
                    width: 32,
                    height: 38,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, bottom: 16),
            child: Text(
              '오늘의 기분',
              style: TextStyle(
                fontFamily: 'SpoqaHanSansNeoBold',
                color: Color(0xFF4A4A4A),
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 158,
            decoration: BoxDecoration(
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
          ),
        ],
      ),
    );
  }
}
