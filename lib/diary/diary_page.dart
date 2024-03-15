import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ihuae/services/calendar_data_service.dart';

import 'package:flutter_ihuae/title_bar.dart';
import 'package:provider/provider.dart';

import 'today_diary_list_container.dart';
import 'today_qn_a_container.dart';
import 'week_list_container.dart';
import 'write_diary_btn.dart';

// 세번째 페이지
class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  int selectedPos = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarDataService>(
        builder: (context, calendarDataService, child) {
      selectedPos = calendarDataService.dDay;
      return Container(
        color: Color(0xFFF5F8FD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleBar(title: "기록"),
            //상단 주일 리스트 영역
            WeekListContainer(setSelectedDayPos: _setSelectedDayPos),
            //오늘의 기록 리스트 영역
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 27),
                    child: Column(
                      children: [
                        //오늘의 문답
                        TodayQnAContainer(
                          index: selectedPos,
                          emoNo: calendarDataService
                              .calendarDataList[selectedPos].todayEmo,
                        ),
                        //간격
                        SizedBox(height: 24),
                        //오늘의 기록
                        Expanded(
                          child: TodayDiaryListContainer(
                              dateID: calendarDataService
                                  .calendarDataList[selectedPos].dateID),
                        ),
                      ],
                    ),
                  ),
                  //기록 추가 버튼
                  Positioned(
                    right: 22.5,
                    bottom: 11.5,
                    child: WriteDiaryBtn(
                        dateID: calendarDataService
                            .calendarDataList[selectedPos].dateID),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void _setSelectedDayPos(int index) {
    setState(() {
      selectedPos = index;
    });
  }
}
