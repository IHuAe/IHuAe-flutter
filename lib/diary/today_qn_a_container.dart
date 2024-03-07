import 'package:flutter/material.dart';

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
