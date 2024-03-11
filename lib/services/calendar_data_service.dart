import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:week_of_year/week_of_year.dart';

import 'package:flutter_ihuae/main.dart';

/**
     * TABLE_NAME : tbCalendar 달력 테이블
     * 1. DateID 날짜ID
     * 2. CalendarYear 년
     * 3. CalendarMonth 월
     * 4. CalendarDay 일
     */

// CalendarData 데이터의 형식을 정해줍니다. 추후 isPinned, updatedAt 등의 정보도 저장할 수 있습니다.
class CalendarData {
  CalendarData({
    required this.dateID,
    required this.calendarYear,
    required this.calendarMonth,
    required this.calendarDay,
    required this.calendarWeek,
    required this.todayEmoIco,
    required this.todayEmoContent,
  });

  int dateID;
  int calendarYear;
  int calendarMonth;
  int calendarDay;
  int calendarWeek;
  String todayEmoIco;
  String todayEmoContent;

  Map toJson() {
    return {
      'dateID': dateID,
      'calendarYear': calendarYear,
      'calendarMonth': calendarMonth,
      'calendarDay': calendarDay,
      'todayEmoIco': todayEmoIco,
      'todayEmoContent': todayEmoContent,
    };
  }

  factory CalendarData.fromJson(json) {
    return CalendarData(
      dateID: json['dateID'],
      calendarYear: json['calendarYear'],
      calendarMonth: json['calendarMonth'],
      calendarDay: json['calendarDay'],
      calendarWeek: json['calendarWeek'],
      todayEmoIco: json['todayEmoIco'],
      todayEmoContent: json['todayEmoContent'],
    );
  }
}

// CalendarData 데이터는 모두 여기서 관리
class CalendarDataService extends ChangeNotifier {
  CalendarDataService() {
    loadCalendarDataList();
  }
  List<CalendarData> calendarDataList = [];

  createCalendarData() {
    var date = DateTime.now();
    for (int i = 0; i < 30; i++) {
      date.add(Duration(days: i));

      int y = date.year;
      //int m = date.month;
      //int d = date.day;
      //int w = date.weekOfYear;
      //int id = int.parse('$y$m$d');
      print('$y');
      // CalendarData calendarData = CalendarData(
      //     dateID: id,
      //     calendarYear: y,
      //     calendarMonth: m,
      //     calendarDay: d,
      //     calendarWeek: w,
      //     todayEmoIco: 'images/emo_circle.png',
      //     todayEmoContent: '');
      // calendarDataList.add(calendarData);

      // saveCalendarDataList();
    }
  }

  saveCalendarDataList() {
    List calendarDataJsonList =
        calendarDataList.map((calendarData) => calendarData.toJson()).toList();
    // [{"content": "1"}, {"content": "2"}]

    String jsonString = jsonEncode(calendarDataJsonList);
    // '[{"content": "1"}, {"content": "2"}]'

    prefs.setString('calendarDataList', jsonString);
  }

  loadCalendarDataList() {
    String? jsonString = prefs.getString('calendarDataList');
    // '[{"content": "1"}, {"content": "2"}]'

    if (jsonString == null) {
      createCalendarData();
      return;
    } //null 이면 첫 접속이기 때문에 달력 데이터 신규 생성

    List calendarDataJsonList = jsonDecode(jsonString);
    // [{"content": "1"}, {"content": "2"}]

    calendarDataList = calendarDataJsonList
        .map((json) => CalendarData.fromJson(json))
        .toList();
  }
}
