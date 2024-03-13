import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ihuae/main.dart';
import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/title_bar.dart';
import 'package:week_of_year/date_week_extensions.dart';

// 두번째 페이지
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _displaySize = MediaQuery.of(context).size;
    double _displaySizeWidth = _displaySize.width;

    double _calendarPadding = 36;
    double _itemWidth = (_displaySizeWidth - _calendarPadding * 2) / 7;

    return Consumer<CalendarDataService>(
        builder: (context, calendarDataService, child) {
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
                  CalendarHandler(calendarPadding: _calendarPadding),
                  SizedBox(height: 37),
                  WeekHeaderContainer(
                      calendarPadding: _calendarPadding, itemWidth: _itemWidth),
                  SizedBox(height: 19),
                  CalendarContainer(
                      calendarDataService: calendarDataService,
                      itemWidth: _itemWidth),
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
    });
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
                          emoList[todayEmoId]['emoIconImage'],
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          emoList[todayEmoId]['emoDescription'],
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

class CalendarHandler extends StatelessWidget {
  const CalendarHandler({
    super.key,
    required double calendarPadding,
  }) : _calendarPadding = calendarPadding;

  final double _calendarPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _calendarPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/btn_cal_left.png',
            width: 12,
            height: 18,
          ),
          Text(
            '4월',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              color: Color(0xFF4A4A4A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Image.asset(
            'images/btn_cal_right.png',
            width: 12,
            height: 18,
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
          WeekHeaderText(weekText: "일", widthSize: _itemWidth),
          WeekHeaderText(weekText: "월", widthSize: _itemWidth),
          WeekHeaderText(weekText: "화", widthSize: _itemWidth),
          WeekHeaderText(weekText: "수", widthSize: _itemWidth),
          WeekHeaderText(weekText: "목", widthSize: _itemWidth),
          WeekHeaderText(weekText: "금", widthSize: _itemWidth),
          WeekHeaderText(weekText: "토", widthSize: _itemWidth),
        ],
      ),
    );
  }
}

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({
    super.key,
    required double itemWidth,
    required this.calendarDataService,
  }) : _itemWidth = itemWidth;

  final double _itemWidth;
  final CalendarDataService calendarDataService;

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  late List<CalendarData> calendarDataList;
  late List<dynamic> testList = [
    [0]
  ];

  @override
  void initState() {
    calendarDataList = widget.calendarDataService.calendarDataList;
    //testList = [];
    int weekOfYearIndex = -1;
    int cnt1 = 0;
    int cnt2 = 0;
    for (CalendarData c in calendarDataList) {
      int wOfy = c.dateValue.weekOfYear;
      if (weekOfYearIndex < 0) weekOfYearIndex = wOfy;
      if (weekOfYearIndex != wOfy) {
        weekOfYearIndex = wOfy;
        cnt1++;
        cnt2 = 0;
      }
      testList[cnt1][cnt2] = c;
      cnt2++;
    }

    print(testList.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36),
      height: 340,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                height: 58,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((innerContext, innerIndex) {
                      return CalendarItem(
                        itemWidth: (widget._itemWidth),
                        itemHeight: 58,
                      );
                    })),
              ),
            ],
          );
        },
      ),
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
  });
  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemWidth,
      height: itemHeight,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5.5),
      //확인용
      // decoration: BoxDecoration(
      //     color: Colors.amber, border: Border.all(color: Colors.white)),
      child: Stack(children: [
        Center(
          child: Opacity(
            opacity: 0.3,
            child: Image.asset(
              "images/ic_emotion_dullness.png",
            ),
          ),
        ),
        Center(
          child: Text(
            "30",
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              //color: Color(0xFF6D6D6D), //TODO 오늘 외
              color: Color(0xFF2D2D2D), //TODO 오늘 날짜
            ),
          ),
        ),
      ]),
    );
  }
}
