import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_ihuae/services/emo_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:week_of_year/date_week_extensions.dart';

import 'package:flutter_ihuae/main.dart';
import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/title_bar.dart';

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
  int _currentPageIndex = 0;
  late PageController _viewPagerController;

  @override
  void initState() {
    _viewPagerController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _viewPagerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _displaySize = MediaQuery.of(context).size;
    double _displaySizeWidth = _displaySize.width;

    double _calendarPadding = 36;
    double _itemWidth = (_displaySizeWidth - _calendarPadding * 2) / 7;

    return Consumer<CalendarDataService>(
      builder: (context, calendarDataService, child) {
        setCalendarDataList(calendarDataService);
        setCalendarDataMap();
        return Container(
          color: Color(0xFFF6F8Fd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  ),
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
                  children: [
                    TitleBar(title: "캘린더"),
                    SizedBox(height: 20),
                    CalendarHandler(
                      monthList: monthList,
                      currentPageIndex: _currentPageIndex,
                      calendarPadding: _calendarPadding,
                      handleViewPagerChanged: _handleViewPagerChanged,
                      updateCurrentPageIndex: _updateCurrentPageIndex,
                    ),
                    SizedBox(height: 37),
                    WeekHeaderContainer(
                        calendarPadding: _calendarPadding,
                        itemWidth: _itemWidth),
                    SizedBox(height: 19),
                    CalendarContainer(
                      calendarDataService: calendarDataService,
                      itemWidth: _itemWidth,
                      calendarDataList: calendarDataList,
                      calendarDataMap: calendarDataMap,
                      monthList: monthList,
                      currentPageIndex: _currentPageIndex,
                      viewPagerController: _viewPagerController,
                      handleViewPagerChanged: _handleViewPagerChanged,
                    ),
                    SizedBox(height: 19),
                  ],
                ),
              ),
              Expanded(
                child:
                    TodayEmoContainer(calendarDataService: calendarDataService),
              ),
            ],
          ),
        );
      },
    );
  }

  void setCalendarDataList(CalendarDataService cs) {
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
}

class TodayEmoContainer extends StatelessWidget {
  const TodayEmoContainer({
    super.key,
    required this.calendarDataService,
  });

  final CalendarDataService calendarDataService;

  @override
  Widget build(BuildContext context) {
    int todayEmoId =
        calendarDataService.calendarDataList[calendarDataService.dDay].todayEmo;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 24, top: 28, bottom: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  '오늘의 기분',
                  style: TextStyle(
                    fontFamily: 'SpoqaHanSansNeo',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A4A4A),
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 158,
                margin: EdgeInsets.only(bottom: 27, left: 20, right: 20),
                padding:
                    EdgeInsets.only(top: 25, bottom: 0, left: 25, right: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          EmoItem(emoNo: todayEmoId).getEmoIconImage(),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          EmoItem(emoNo: todayEmoId).getEmoDescription(),
                          style: TextStyle(
                            fontFamily: "SpoqaHanSansNeo",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 19),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        calendarDataService
                            .calendarDataList[calendarDataService.dDay]
                            .todayEmoContent,
                        //"sldfskflsdkjfsl;dfjdsklfjsd;lkfjs;lkfjsl;fkjsd;lkfjsd;lkfjsl;kjfd;",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          fontFamily: "SpoqaHanSansNeo",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CalendarHandler extends StatefulWidget {
  const CalendarHandler({
    super.key,
    required this.calendarPadding,
    required this.monthList,
    required this.currentPageIndex,
    required this.handleViewPagerChanged,
    required this.updateCurrentPageIndex,
  });

  final double calendarPadding;

  final List<int> monthList;
  final int currentPageIndex;
  final void Function(int) handleViewPagerChanged;
  final void Function(int) updateCurrentPageIndex;

  @override
  State<CalendarHandler> createState() => _CalendarHandlerState();
}

class _CalendarHandlerState extends State<CalendarHandler> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.calendarPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.currentPageIndex > 0) {
                widget.updateCurrentPageIndex(widget.currentPageIndex - 1);
              }
            },
            child: Image.asset(
              'images/btn_cal_left.png',
              width: 12,
              height: 18,
            ),
          ),
          Text(
            '${widget.monthList[widget.currentPageIndex]}월',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              color: Color(0xFF4A4A4A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.currentPageIndex < widget.monthList.length) {
                widget.updateCurrentPageIndex(widget.currentPageIndex + 1);
              }
            },
            child: Image.asset(
              'images/btn_cal_right.png',
              width: 12,
              height: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class WeekHeaderContainer extends StatelessWidget {
  const WeekHeaderContainer({
    super.key,
    required double calendarPadding,
    required double itemWidth,
  })  : _calendarPadding = calendarPadding,
        _itemWidth = itemWidth;

  final double _calendarPadding;
  final double _itemWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _calendarPadding),
      child: Row(
        children: [
          WeekHeaderText(weekText: "월", widthSize: _itemWidth),
          WeekHeaderText(weekText: "화", widthSize: _itemWidth),
          WeekHeaderText(weekText: "수", widthSize: _itemWidth),
          WeekHeaderText(weekText: "목", widthSize: _itemWidth),
          WeekHeaderText(weekText: "금", widthSize: _itemWidth),
          WeekHeaderText(weekText: "토", widthSize: _itemWidth),
          WeekHeaderText(weekText: "일", widthSize: _itemWidth),
        ],
      ),
    );
  }
}

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({
    super.key,
    required this.itemWidth,
    required this.calendarDataService,
    required this.calendarDataList,
    required this.calendarDataMap,
    required this.monthList,
    required this.currentPageIndex,
    required this.viewPagerController,
    required this.handleViewPagerChanged,
  });

  final double itemWidth;
  final CalendarDataService calendarDataService;

  final List<CalendarData> calendarDataList;
  final Map calendarDataMap;
  final List<int> monthList;
  final int currentPageIndex;
  final PageController viewPagerController;
  final void Function(int) handleViewPagerChanged;

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36),
      height: 340,
      child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: widget.viewPagerController,
          onPageChanged: widget.handleViewPagerChanged,
          itemCount: widget.calendarDataMap.length,
          itemBuilder: (BuildContext pageContext, int pageIndex) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  widget.calendarDataMap[widget.monthList[pageIndex]].length,
              itemBuilder: (BuildContext weekContext, int weekIndex) {
                return SizedBox(
                  height: 58,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget
                          .calendarDataMap[widget.monthList[pageIndex]]
                              [weekIndex]
                          .length,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((innerContext, innerIndex) {
                        return CalendarItem(
                          itemWidth: (widget.itemWidth),
                          itemHeight: 58,
                          calendarData: widget
                                  .calendarDataMap[widget.monthList[pageIndex]]
                              [weekIndex][innerIndex],
                        );
                      })),
                );
              },
            );
          }),
    );
  }
}

class WeekHeaderText extends StatelessWidget {
  const WeekHeaderText({
    super.key,
    required this.weekText,
    required this.widthSize,
  });
  final String weekText;
  final double widthSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      alignment: Alignment.center,
      child: Text(
        weekText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'SpoqaHanSansNeo',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
    required this.calendarData,
  });
  final double itemWidth;
  final double itemHeight;
  final CalendarData calendarData;

  @override
  Widget build(BuildContext context) {
    int calDay = calendarData.dateValue.day;
    bool isFirstDay = calDay == 1;
    bool isToday = false;
    if (calendarData.dateID ==
        int.parse(DateFormat('yyyyMMdd').format(DateTime.now()).toString())) {
      isToday = true;
    }
    return Container(
      width: itemWidth,
      height: itemHeight,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5.5),
      margin: EdgeInsets.only(
          left: (isFirstDay
              ? (calendarData.dateValue.weekday - 1) * itemWidth
              : 0)),
      child: Stack(children: [
        if (calendarData.todayEmo != 0)
          Center(
            child: Opacity(
              opacity: isToday ? 1.0 : 0.3,
              child: Image.asset(
                EmoItem(emoNo: calendarData.todayEmo).getEmoIconImage(),
              ),
            ),
          ),
        Center(
          child: Text(
            '$calDay',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
              fontSize: 12,
              color: isToday ? Color(0xFF2D2D2D) : Color(0xFF6D6D6D),
            ),
          ),
        ),
      ]),
    );
  }
}
