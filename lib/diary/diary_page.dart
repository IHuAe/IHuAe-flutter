import 'package:flutter/material.dart';

import 'package:flutter_ihuae/title_bar.dart';

// 세번째 페이지
class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleBar(title: "기록"),
        Container(
          margin: EdgeInsets.only(top: 6),
          padding: EdgeInsets.only(top: 11, bottom: 20),
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
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  'D+DAY',
                  style: TextStyle(
                    fontFamily: 'SpoqaHanSansNeo',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7, // RecyclerView의 아이템 수에 맞게 조절하세요
                  itemBuilder: (context, index) {
                    return WeekItem(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 27),
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
                height: 144,
                color: Colors.pink, // RecyclerView의 높이에 맞게 조절하세요
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
    );
  }
}

class WeekItem extends StatelessWidget {
  const WeekItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (index == 0) SizedBox(width: 20),
        Container(
          height: 30,
          width: 40,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "images/ic_emotion_sadness.png", //TODO 유저가 설정한 이미지로
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    "30", //일 수 맞춰서
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF6D6D6D),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
