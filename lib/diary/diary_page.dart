import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';

import '../chat/chat_page.dart';

// 세번째 페이지
class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FD),
      appBar: AppBar(
        title: Text('Your Title'),
        // include 태그로 추가되는 툴바를 이곳에 추가하세요
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 6),
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'D+DAY',
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeoMedium',
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 200, // RecyclerView의 높이에 맞게 조절하세요
                    child: ListView.builder(
                      itemCount: 10, // RecyclerView의 아이템 수에 맞게 조절하세요
                      itemBuilder: (context, index) {
                        return Text("test");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘의 문답',
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeoBold',
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 144, // RecyclerView의 높이에 맞게 조절하세요
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10, // RecyclerView의 아이템 수에 맞게 조절하세요
                      itemBuilder: (context, index) {
                        return Text(""); //YourHorizontalListItemWidget();
                      },
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '오늘의 기록',
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeoBold',
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 14),
                  Container(
                    height: 200, // RecyclerView의 높이에 맞게 조절하세요
                    child: ListView.builder(
                      itemCount: 10, // RecyclerView의 아이템 수에 맞게 조절하세요
                      itemBuilder: (context, index) {
                        return Text("");
                      },
                    ),
                  ),
                  SizedBox(height: 11),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FloatingActionButton(
                        onPressed: () {
                          // 기록 추가 버튼을 눌렀을 때 동작
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
