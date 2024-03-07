import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_ihuae/title_bar.dart';

import 'today_diary_list_container.dart';
import 'today_qn_a_container.dart';
import 'week_list_container.dart';
import 'write_diary_btn.dart';

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
