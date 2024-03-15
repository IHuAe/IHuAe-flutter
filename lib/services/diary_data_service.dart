import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';

class DiaryData {
  DiaryData({
    required this.diaryTitle,
    required this.diaryContent,
  });

  String diaryTitle;
  String diaryContent;

  Map toJson() {
    return {
      'diaryTitle': diaryTitle,
      'diaryContent': diaryContent,
    };
  }

  factory DiaryData.fromJson(json) {
    return DiaryData(
      diaryTitle: json['diaryTitle'],
      diaryContent: json['diaryContent'],
    );
  }
}

class DiaryDataService extends ChangeNotifier {
  Map diaryDataMap = HashMap();
  DiaryDataService() {
    loadDiaryDataMap();
  }

  //diaryDataMap 불러오기
  loadDiaryDataMap() {
    String? jsonString = prefs.getString('diaryDataMap');

    if (jsonString == null) {
      return;
    }
    print(
        "================$jsonString=====================================================");
    Map diaryDataJsonMap = jsonDecode(jsonString);
    print("===============step1");
    Iterable keys = diaryDataJsonMap.keys;
    print("===============step2");
    for (var k in keys) {
      print("===============step3");
      List diaryDataJsonList = diaryDataJsonMap[k];
      print("===============step4");
      List diaryDataList =
          diaryDataJsonList.map((json) => DiaryData.fromJson(json)).toList();
      diaryDataMap[k] = diaryDataList;
    }

    // calendarDataList = calendarDataJsonList
    //     .map((json) => CalendarData.fromJson(json))ajou
    //     .toList();
  }

  //diaryDataMap 로컬 저장
  saveDiaryDataMap() {
    Map diaryDataJsonMap = HashMap();
    Iterable keys = diaryDataMap.keys;
    //String jsonString = '{';
    String jsonString = '';
    //bool isFirst = true;
    for (var k in keys) {
      List<DiaryData> diaryDataList = diaryDataMap[k];
      List diaryDataJsonList =
          diaryDataList.map((diaryData) => diaryData.toJson()).toList();
      print(
          "=========saveDiaryDataMap diaryDataJsonList:=======$diaryDataJsonList=====================================================");
      diaryDataJsonMap[k] = diaryDataJsonList;

      // if (isFirst) {
      //   jsonString += '"$k": $diaryDataJsonList';
      // } else {
      //   jsonString += ', "$k": $diaryDataJsonList';
      // }

      //isFirst = false;
    }
    //jsonString += "}";
    //jsonString = _convertToJsonStringQuotes(raw: diaryDataJsonMap.toString());
    //// diaryDataJsonMap.toString(); //jsonEncode(diaryDataJsonMap);
    jsonString = jsonEncode(diaryDataJsonMap);
    print(
        "=========saveDiaryDataMap:=======$jsonString=====================================================");
    prefs.setString('diaryDataMap', jsonString);
  }

  String _convertToJsonStringQuotes({required String raw}) {
    /// remove space
    String jsonString = raw.replaceAll(" ", "");

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(':', '": "');
    jsonString = jsonString.replaceAll(',', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }

  createNewDiaryData(int dateID, String title, String content) {
    List<DiaryData> diaryList = diaryDataMap[dateID] ?? [];

    DiaryData diaryData = DiaryData(diaryTitle: title, diaryContent: content);
    diaryList.add(diaryData);
    diaryDataMap[dateID] = diaryList;

    notifyListeners();
    saveDiaryDataMap();
  }

  updateDiaryData(int dateID, int diaryIndex, String title, String content) {
    List<DiaryData> diaryList = diaryDataMap[dateID];
    DiaryData diaryData = diaryList[diaryIndex];
    diaryData.diaryTitle = title;
    diaryData.diaryContent = content;

    notifyListeners();
    saveDiaryDataMap();
  }

  deleteDiaryData(int dateID, int diaryIndex) {
    List<DiaryData> diaryList = diaryDataMap[dateID];
    diaryList.removeAt(diaryIndex);

    notifyListeners();
    saveDiaryDataMap();
  }
}
