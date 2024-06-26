import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/services/diary_data_service.dart';
import 'package:flutter_ihuae/title_bar.dart';
import 'package:flutter_ihuae/diary/d_day_list_container.dart';
import 'package:flutter_ihuae/diary/today_qn_a_container.dart';
import 'package:flutter_ihuae/diary/today_diary_list_container.dart';
import 'package:flutter_ihuae/diary/write_diary_btn.dart';

// 세번째 페이지
class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  int selectedPos = -1;
  List<GlobalKey> globalkeys = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarDataService>(
        builder: (context, calendarDataService, child) {
      return Consumer<DiaryDataService>(
          builder: (context, diaryDataService, child) {
        selectedPos =
            selectedPos == -1 ? calendarDataService.dDay : selectedPos;
        globalkeys = List.generate(calendarDataService.calendarDataList.length,
            (index) => GlobalKey());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Scrollable.ensureVisible(
            globalkeys[selectedPos > 0 ? selectedPos - 1 : selectedPos]
                .currentContext!,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        });

        return Container(
          color: Color(0xFFF5F8FD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleBar(title: "기록"),
              //상단  리스트 영역
              DDayListContainer(
                  globalkeys: globalkeys,
                  setSelectedDayPos: _setSelectedDayPos),
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
                          diaryDataService: diaryDataService,
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
    });
  }

  void _setSelectedDayPos(int index) {
    setState(() {
      selectedPos = index;
    });
  }
}
