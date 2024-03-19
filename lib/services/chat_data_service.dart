import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';

class ChatData {
  ChatData({
    required this.content,
    required this.regDateTime,
  });

  String content;
  DateTime regDateTime;

  Map toJson() {
    return {
      'content': content,
      'regDateTime': regDateTime,
    };
  }

  factory ChatData.fromJson(json) {
    return ChatData(
      content: json['content'],
      regDateTime: DateTime.parse(json['regDateTime']),
    );
  }
}

class ChatDataService extends ChangeNotifier {
  List<ChatData> chatDataList = [];

  ChatDataService() {
    loadChatDataList();
  }

  //chatDataList 불러오기
  loadChatDataList() {
    String? jsonString = prefs.getString('chatDataList');

    if (jsonString == null) {
      return;
    }
    List chatDataJsonList = jsonDecode(jsonString);
    chatDataList =
        chatDataJsonList.map((json) => ChatData.fromJson(json)).toList();

    for (var i = 0; i < chatDataList.length; i++) {
      int difference = int.parse(DateTime.now()
          .difference(chatDataList[i].regDateTime)
          .inDays
          .toString());
      if (difference >= 1) {
        chatDataList.removeAt(i);
      }
    }
  }

  //chatDataList 로컬 저장
  saveChatDataList() {
    List chatDataJsonList =
        chatDataList.map((chatData) => chatData.toJson()).toList();

    String jsonString = jsonEncode(chatDataJsonList, toEncodable: myEncode);

    prefs.setString('chatDataList', jsonString);
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  createChatData(String content) {
    ChatData newChatData =
        ChatData(content: content, regDateTime: DateTime.now());
    chatDataList.add(newChatData);

    notifyListeners();
    saveChatDataList();
  }

  deleteChatData(int index) {}
}
