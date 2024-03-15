import 'package:flutter/material.dart';

class EmoItem {
  EmoItem({required this.emoNo});
  int emoNo = 0;
  String getEmoIconImage() {
    return emoItemList[emoNo]['emoIconImage'];
  }

  String getEmoName() {
    return emoItemList[emoNo]['emoName'];
  }

  String getEmoDescription() {
    return emoItemList[emoNo]['emoDescription'];
  }

  Color getEmoColor() {
    return emoItemList[emoNo]['emoColor'];
  }

  Color getEmoGradientColor() {
    return emoItemList[emoNo]['emoGradientColor'];
  }

  Color getEmoStrokeColor() {
    return emoItemList[emoNo]['emoStrokeColor'];
  }

  Color getEmoTextColor() {
    return emoItemList[emoNo]['emoTextColor'];
  }

  List<Map> emoItemList = [
    {
      "emoNo": 0,
      "emoIconImage": "images/emo_circle.png",
      "emoName": "오늘의 기분을 표현해보세요",
      "emoDescription": "오늘은 어떤 기분이 드나요?",
      "emoColor": Color.fromARGB(77, 255, 255, 255),
      "emoGradientColor": Color(0xFF000000),
      "emoStrokeColor": Color.fromARGB(77, 255, 255, 255),
      "emoTextColor": Colors.black,
    },
    {
      "emoNo": 1,
      "emoIconImage": "images/ic_emotion_calmness.png",
      "emoName": "평온",
      "emoDescription": "오늘은 평온함",
      "emoColor": Color(0xFFFFE9BA),
      "emoGradientColor": Color(0xFFF8DEA9),
      "emoStrokeColor": Color(0xFFFFE9BA),
      "emoTextColor": Color(0xFFF1AA16),
    },
    {
      "emoNo": 2,
      "emoIconImage": "images/ic_emotion_dullness.png",
      "emoName": "무덤덤",
      "emoDescription": "오늘은 무덤덤함",
      "emoColor": Color(0xFFEFE7F6),
      "emoGradientColor": Color(0xFFEEDAFF),
      "emoStrokeColor": Color(0xFFEBDFF4),
      "emoTextColor": Color(0xFFBE96D3),
    },
    {
      "emoNo": 3,
      "emoIconImage": "images/ic_emotion_sadness.png",
      "emoName": "슬픔",
      "emoDescription": "오늘은 슬픔",
      "emoColor": Color(0xFFDFE9F8),
      "emoGradientColor": Color(0xFFB4CFF5),
      "emoStrokeColor": Color(0xFFDFE9F8),
      "emoTextColor": Color(0xFF5786C8),
    },
    {
      "emoNo": 4,
      "emoIconImage": "images/ic_emotion_anger.png",
      "emoName": "분노",
      "emoDescription": "오늘은 화남",
      "emoColor": Color(0xFFFBE9E9),
      "emoGradientColor": Color(0xFFF9D7D7),
      "emoStrokeColor": Color(0xFFFBE9E9),
      "emoTextColor": Color(0xFFE87C7C),
    },
    {
      "emoNo": 5,
      "emoIconImage": "images/ic_emotion_satisfied.png",
      "emoName": "만족",
      "emoDescription": "오늘은 만족스러움",
      "emoColor": Color(0xFFDDEDDD),
      "emoGradientColor": Color(0xFFB4CFF5),
      "emoStrokeColor": Color(0xFFDDEDDD),
      "emoTextColor": Color(0xFF86AD84),
    },
    {
      "emoNo": 6,
      "emoIconImage": "images/ic_emotion_emptiness.png",
      "emoName": "공허함",
      "emoDescription": "오늘은 공허함",
      "emoColor": Color(0xFFEFEFEF),
      "emoGradientColor": Color(0xFFC3D4D9),
      "emoStrokeColor": Color(0xFFEFEFEF),
      "emoTextColor": Color(0xFF89A6AF),
    },
  ];
}
