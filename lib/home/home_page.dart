import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';

import '../chat/chat_page.dart';

// 첫번째 페이지
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF6F8FD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 18, left: 20, right: 23, bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Text(
                        "D-Day",
                        style: TextStyle(
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8291E6),
                          fontSize: 24,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "오늘의 기분을 표현해보세요",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //fontFamily: 'SpoqaHanSansNeoBold',
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8291E6),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Image.asset(
                        'images/emo_circle.png',
                        width: 27,
                        height: 27,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "하루문답",
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeoBold',
                      color: Color(0xFF8291E6),
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "오늘의 질문",
                          style: TextStyle(
                            fontFamily: 'SpoqaHanSansNeoMedium',
                            color: Color(0xFF8291E6),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        width: 82,
                        height: 28,
                        margin: const EdgeInsets.only(right: 11),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF8996F3),
                        ),
                        child: const Center(
                          child: Text(
                            "기록하기",
                            style: TextStyle(
                              fontFamily: 'SpoqaHanSansNeoMedium',
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                  child: Image.asset(
                    'images/arr_left.png',
                    width: 32,
                    height: 48,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: const Placeholder(), // ViewPager2를 대체할 위젯을 넣으세요.
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159), // 180도 회전
                    child: Image.asset(
                      'images/arr_left.png',
                      width: 32,
                      height: 48,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
