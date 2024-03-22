import 'package:flutter/material.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/services/emo_item.dart';

class TodayEmoContainer extends StatefulWidget {
  const TodayEmoContainer({
    super.key,
    required this.selectedCalData,
  });
  final CalendarData selectedCalData;

  @override
  State<TodayEmoContainer> createState() => _TodayEmoContainerState();
}

class _TodayEmoContainerState extends State<TodayEmoContainer> {
  @override
  Widget build(BuildContext context) {
    int todayEmoId = widget.selectedCalData.todayEmo;
    return Column(
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
          margin: EdgeInsets.only(bottom: 27, left: 20, right: 20),
          padding: EdgeInsets.only(top: 25, bottom: 20, left: 25, right: 25),
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
                  widget.selectedCalData.todayEmoContent,
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
        SizedBox(height: 27),
      ],
    );
  }
}
