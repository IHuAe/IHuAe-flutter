import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_ihuae/title_bar.dart';

// 세번째 페이지
class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F8FD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleBar(title: "기록"),
          //상단 주일 리스트 영역
          WeekListContainer(),
          //오늘의 기록 리스트 영역
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 27),
                  child: Column(
                    children: [
                      //오늘의 문답
                      TodayQnAContainer(),
                      //간격
                      SizedBox(height: 24),
                      //오늘의 기록
                      Expanded(
                        child: TodayDiaryListContainer(),
                      ),
                    ],
                  ),
                ),
                //기록 추가 버튼
                Positioned(
                  right: 22.5,
                  bottom: 11.5,
                  child: WriteDiaryBtn(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodayDiaryListContainer extends StatelessWidget {
  const TodayDiaryListContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 기록',
          style: TextStyle(
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A4A4A),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 14),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0, bottom: 90, right: 0, left: 0),
            itemCount: 5, // RecyclerView의 아이템 수에 맞게 조절하세요
            itemBuilder: (context, index) {
              return Container(
                  height: 88,
                  margin: EdgeInsets.only(top: 0, bottom: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1.0,
                        color: Color(0xFFECECEC),
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3.0))),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "data",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SpoqaHanSansNeo',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF7A7A7A),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("삭제");
                                },
                                child: Text(
                                  "삭제",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'SpoqaHanSansNeo',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4A4A4A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "datadssfsfsdlksjlksdjflsdkfjlsjsdlfkdjslkjsddsdsfsdsfsfsdslkjl",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SpoqaHanSansNeo',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9A9A9A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}

class TodayQnAContainer extends StatelessWidget {
  const TodayQnAContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 문답',
          style: TextStyle(
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A4A4A),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 10),
        Material(
          elevation: 4,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 144,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Color(0xFFEBDFF4),
              ),
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: [Color(0xFFEBDFF4), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Text(
                        "Q.1",
                        style: TextStyle(
                          color: Color(0xFFBE96D3),
                          fontSize: 16,
                          fontFamily: '',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "X와 어떻게 헤어졌는지 자세히 말해줄래요?X와 어떻게 헤어졌는지 자세히 말해줄래요?X와 어떻게 헤어졌는지 자세히 말해줄래요?X와 어떻게 헤어졌는지 자세히 말해줄래요?X와 어떻게 헤어졌는지 자세히 말해줄래요?X와 어떻게 헤어졌는지 자세히 말해줄래요?X와 어떻게 헤어졌는지 자세히 말해줄래요?",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Color(0xFFBE96D3),
                          fontSize: 16,
                          fontFamily: '',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 62),
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "기록하기",
                    style: TextStyle(
                      color: Color(0xFFBE96D3),
                      fontSize: 12,
                      fontFamily: '',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WeekListContainer extends StatelessWidget {
  const WeekListContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 0),
              scrollDirection: Axis.horizontal,
              itemCount: 7, // RecyclerView의 아이템 수에 맞게 조절하세요
              itemBuilder: (context, index) {
                return WeekItem(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WriteDiaryBtn extends StatelessWidget {
  const WriteDiaryBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Color(0xFF8291E6),
      onPressed: () {},
      child: Center(
        child: Text(
          "+",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
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
