import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:week_of_year/date_week_extensions.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/title_bar.dart';
import 'package:flutter_ihuae/calendar/calendar_container.dart';
import 'package:flutter_ihuae/calendar/calendar_handler.dart';
import 'package:flutter_ihuae/calendar/calendar_week_header_container.dart';
import 'package:flutter_ihuae/calendar/today_emo_container.dart';

// 두번째 페이지
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<CalendarData> calendarDataList = [];
  Map calendarDataMap = HashMap();
  List<int> monthList = [];
  int _currentPageIndex = -1;
  late PageController _viewPagerController;
  bool isInit = false;
  late CalendarData _selectedCalData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _viewPagerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size displaySize = MediaQuery.of(context).size;
    double displaySizeWidth = displaySize.width;

    double calendarPadding = 36;
    double itemWidth = (displaySizeWidth - calendarPadding * 2) / 7;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Consumer<CalendarDataService>(
      builder: (context, calendarDataService, child) {
        setCalendarDataList(calendarDataService);
        setCalendarDataMap();
        if (!isInit) {
          _selectedCalData =
              calendarDataService.calendarDataList[calendarDataService.dDay];
        }
        if (_currentPageIndex == -1) {
          initCurrentPageIndex(calendarDataService.dDay);
        }
        _viewPagerController = PageController(initialPage: _currentPageIndex);

        isInit = true;
        return Column(
          children: [
            Card(
              elevation: 6,
              margin: EdgeInsets.all(0),
              shadowColor: Colors.transparent,
              child: Container(
                height: statusBarHeight,
                color: Colors.white,
              ),
            ),
            Card(
              elevation: 6,
              margin: EdgeInsets.all(0),
              shadowColor: Colors.transparent,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.white,
                child: Text(
                  "캘린더",
                  style: TextStyle(
                    fontFamily: 'SpoqaHanSansNeo',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A4A4A),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Color(0xFFF6F8Fd),
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        color: Colors.white,
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(23),
                            bottomRight: Radius.circular(23),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(23),
                              bottomRight: Radius.circular(23),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              CalendarHandler(
                                monthList: monthList,
                                currentPageIndex: _currentPageIndex,
                                calendarPadding: calendarPadding,
                                updateCurrentPageIndex: _updateCurrentPageIndex,
                              ),
                              SizedBox(height: 27),
                              CalendarWeekHeaderContainer(
                                  calendarPadding: calendarPadding,
                                  itemWidth: itemWidth),
                              SizedBox(height: 19),
                              CalendarContainer(
                                calendarDataService: calendarDataService,
                                itemWidth: itemWidth,
                                calendarDataMap: calendarDataMap,
                                monthList: monthList,
                                currentPageIndex: _currentPageIndex,
                                viewPagerController: _viewPagerController,
                                handleViewPagerChanged: _handleViewPagerChanged,
                                updateSelectedCalData:
                                    _updateSelectedCalDataIndex,
                              ),
                              SizedBox(height: 19),
                            ],
                          ),
                        ),
                      ),
                      TodayEmoContainer(selectedCalData: _selectedCalData),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void setCalendarDataList(CalendarDataService cs) {
    calendarDataList.clear();
    //시작한 달의 비활성화 날짜 가져오기
    CalendarData firstData = cs.calendarDataList[0];
    DateTime fistDate = firstData.dateValue;

    if (fistDate.day > 1) {
      for (int j = fistDate.day - 1; 0 < j; j--) {
        DateTime calDate1 = fistDate.subtract(Duration(days: j));
        String sdfString1 = DateFormat('yyyyMMdd').format(calDate1).toString();
        int id1 = int.parse(sdfString1);

        CalendarData calendarData1 = CalendarData(
          dateID: id1,
          dateValue: calDate1,
          todayEmoContent: '',
          isEnabled: false,
          todayEmo: 0,
        );
        calendarDataList.add(calendarData1);
      }
    }

    calendarDataList.addAll(cs.calendarDataList);

    //마지막 달의 비활성화 날짜 가져오기
    CalendarData lastEnableData = calendarDataList[calendarDataList.length - 1];
    DateTime lastEnableDate = lastEnableData.dateValue;
    DateTime lastDate =
        DateTime(lastEnableDate.year, lastEnableDate.month + 1, 0);
    if (lastEnableDate.day != lastDate.day) {
      for (int x = lastEnableDate.day + 1; x < lastDate.day + 1; x++) {
        DateTime calDate3 =
            DateTime(lastEnableDate.year, lastEnableDate.month, x);
        String sdfString3 = DateFormat('yyyyMMdd').format(calDate3).toString();
        int id3 = int.parse(sdfString3);

        CalendarData calendarData3 = CalendarData(
          dateID: id3,
          dateValue: calDate3,
          todayEmoContent: '',
          isEnabled: false,
          todayEmo: 0,
        );
        calendarDataList.add(calendarData3);
      }
    }
  }

  void initCurrentPageIndex(int dDay) {
    int todayMonth = calendarDataList[dDay].dateValue.month;
    for (var i = 0; i < monthList.length; i++) {
      if (monthList[i] == todayMonth) {
        _currentPageIndex = i;
        return;
      }
    }
  }

  void setCalendarDataMap() {
    int weekOfYearIndex = -1;
    int cnt1 = -1;
    int monthKey = 0;
    calendarDataMap.clear();

    for (CalendarData c in calendarDataList) {
      if (monthKey != c.dateValue.month) {
        weekOfYearIndex = -1;
        cnt1 = -1;
        monthKey = c.dateValue.month;
        monthList.add(monthKey);
      }

      Map weekDataHash = calendarDataMap[monthKey] ?? HashMap();

      int wOfy = c.dateValue.weekOfYear;

      if (weekOfYearIndex != wOfy) {
        weekOfYearIndex = wOfy;
        cnt1++;
      }
      List<CalendarData> week = weekDataHash[cnt1] ?? [];
      week.add(c);
      weekDataHash[cnt1] = week;

      calendarDataMap[monthKey] = weekDataHash;
    }
  }

  void _handleViewPagerChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _viewPagerController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _updateSelectedCalDataIndex(CalendarData calData) {
    setState(() {
      _selectedCalData = calData;
    });
  }
}
