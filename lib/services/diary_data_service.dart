import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';

class DiaryData {
  DiaryData({
    required this.diaryTitle,
    required this.diaryContent,
    required this.editDateTime,
  });

  String diaryTitle;
  String diaryContent;
  DateTime editDateTime;

  Map toJson() {
    return {
      'diaryTitle': diaryTitle,
      'diaryContent': diaryContent,
      'editDateTime': editDateTime,
    };
  }

  factory DiaryData.fromJson(json) {
    return DiaryData(
      diaryTitle: json['diaryTitle'],
      diaryContent: json['diaryContent'],
      editDateTime: DateTime.parse(json['editDateTime']),
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

    Map diaryDataJsonMap1 = jsonDecode(jsonString);
    Map diaryDataJsonMap2 = diaryDataJsonMap1.map<int, String>(
      (k, v) => MapEntry(int.parse(k), v), // parse String back to int
    );
    Iterable keys = diaryDataJsonMap2.keys;

    for (var k in keys) {
      var listJsonString = diaryDataJsonMap2[k];
      if (listJsonString == null) continue;
      List diaryDataJsonList = jsonDecode(listJsonString);
      List diaryDataList =
          diaryDataJsonList.map((json) => DiaryData.fromJson(json)).toList();
      diaryDataMap[k] = diaryDataList;
    }
  }

  //diaryDataMap 로컬 저장
  saveDiaryDataMap() {
    Map diaryDataJsonMap1 = HashMap();
    Iterable keys = diaryDataMap.keys;
    String jsonString = '';

    for (var k in keys) {
      List<DiaryData> diaryDataList = diaryDataMap[k];

      List diaryDataJsonList =
          diaryDataList.map((diaryData) => diaryData.toJson()).toList();
      String listJsonString =
          jsonEncode(diaryDataJsonList, toEncodable: myEncode);
      diaryDataJsonMap1[k] = listJsonString;
    }

    Map diaryDataJsonMap2 = diaryDataJsonMap1.map<String, String>(
      (k, v) => MapEntry(k.toString(), v), // convert int to String
    );
    jsonString = jsonEncode(diaryDataJsonMap2);

    prefs.setString('diaryDataMap', jsonString);
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  createNewDiaryData(int dateID, String title, String content) {
    List<DiaryData> diaryList = diaryDataMap[dateID] ?? [];

    DiaryData diaryData = DiaryData(
        diaryTitle: title, diaryContent: content, editDateTime: DateTime.now());
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
    diaryData.editDateTime = DateTime.now();

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
