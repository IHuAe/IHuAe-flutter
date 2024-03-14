import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_ihuae/main.dart';

// CalendarData 데이터의 형식을 정해줍니다. 추후 isPinned, updatedAt 등의 정보도 저장할 수 있습니다.
class CalendarData {
  CalendarData({
    required this.dateID,
    required this.dateValue,
    required this.todayEmo,
    required this.todayEmoContent,
    required this.isEnabled,
  });

  int dateID;
  DateTime dateValue;

  int todayEmo =
      0; /* 0 미선택,
            1 calmness 평온, 
            2 dullness 무덤덤, 
            3 sadness 슬픔, 
            4 anger 분노, 
            5 satisfied 만족, 
            6 emptiness 공허함 */
  String todayEmoContent = "";
  bool isEnabled = false;

  Map toJson() {
    return {
      'dateID': dateID,
      'dateValue': dateValue,
      'todayEmo': todayEmo,
      'todayEmoContent': todayEmoContent,
      'isEnabled': isEnabled,
    };
  }

  factory CalendarData.fromJson(json) {
    return CalendarData(
      dateID: json['dateID'],
      dateValue: DateTime.parse(json['dateValue']),
      todayEmo: json['todayEmo'],
      todayEmoContent: json['todayEmoContent'],
      isEnabled: json['isEnabled'],
    );
  }
}

// CalendarData 데이터는 모두 여기서 관리
class CalendarDataService extends ChangeNotifier {
  final int maxDayCnt = 30;
  List<CalendarData> calendarDataList = [];
  int dDay = 0;
  CalendarDataService() {
    loadCalendarDataList();
  }

  createCalendarData() {
    DateTime newDate = DateTime.now();

    //시간 0으로 초기화
    DateTime date = newDate.subtract(Duration(
        hours: newDate.hour,
        minutes: newDate.minute,
        seconds: newDate.second,
        milliseconds: newDate.millisecond,
        microseconds: newDate.microsecond));

    //시작일 저장
    saveStartDate(date);

    //시작부터 30일, 활성화 날짜 가져오기
    for (int i = 0; i < maxDayCnt; i++) {
      DateTime calDate2 = date.add(Duration(days: i));
      String sdfString2 = DateFormat('yyyyMMdd').format(calDate2).toString();
      int id2 = int.parse(sdfString2);

      CalendarData calendarData2 = CalendarData(
        dateID: id2,
        dateValue: calDate2,
        todayEmo: 0,
        todayEmoContent: '',
        isEnabled: true,
      );
      calendarDataList.add(calendarData2);
    }
    saveCalendarDataList();
  }

  //calendarDataList 로컬 저장
  saveCalendarDataList() {
    List calendarDataJsonList =
        calendarDataList.map((calendarData) => calendarData.toJson()).toList();

    String jsonString = jsonEncode(calendarDataJsonList, toEncodable: myEncode);

    prefs.setString('calendarDataList', jsonString);
  }

  //calendarDataList 불러오기 + 시작일 불러와 dDay계산하기
  loadCalendarDataList() {
    String? jsonString = prefs.getString('calendarDataList');

    if (jsonString == null) {
      dDay = 0;
      createCalendarData();
      return;
    } //null 이면 첫 접속이기 때문에 달력 데이터 신규 생성
    dDay = calcularDDay(); //시작일과 오늘 날짜 차를 계산하여 dDay 가져오기
    List calendarDataJsonList = jsonDecode(jsonString);

    calendarDataList = calendarDataJsonList
        .map((json) => CalendarData.fromJson(json))
        .toList();
  }

  //시작일 저장
  saveStartDate(DateTime startDate) {
    String jsonString = startDate.toString();
    prefs.setString('startDate', jsonString);
  }

  //dDay 계산
  int calcularDDay() {
    int difference = 0;
    String? jsonString = prefs.getString('startDate');
    if (jsonString == null) {
      return difference;
    }
    DateTime newDate = DateTime.now();
    //시간 0으로 초기화
    DateTime today = newDate.subtract(Duration(
        hours: newDate.hour,
        minutes: newDate.minute,
        seconds: newDate.second,
        milliseconds: newDate.millisecond,
        microseconds: newDate.microsecond));
    DateTime startDate = DateTime.parse(jsonString);

    difference = int.parse(today.difference(startDate).inDays.toString());

    if (difference >= maxDayCnt) difference = maxDayCnt - 1;

    return difference;
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  updateTodayEmo(
    int index,
    int todayEmo,
    String todayEmoContent,
  ) {
    CalendarData data = calendarDataList[index];
    data.todayEmo = todayEmo;
    data.todayEmoContent = todayEmoContent;

    notifyListeners();
    saveCalendarDataList();
  }
}
