import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ihuae/services/emo_item.dart';
import 'package:flutter_ihuae/services/qna_data_service.dart';
import 'package:flutter_ihuae/diary/write_qna_btn.dart';

class TodayQnAContainer extends StatelessWidget {
  const TodayQnAContainer({
    super.key,
    required this.index,
    required this.emoNo,
  });
  final int index;
  final int emoNo;

  @override
  Widget build(BuildContext context) {
    return Consumer<QnaDataService>(builder: (context, qnaDataService, child) {
      List<QnaData> qnaDataList = qnaDataService.qnaDataList;
      bool isAnsEmpty = qnaDataList[index].answer.isEmpty;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '오늘의 문답',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A4A4A),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Material(
            elevation: 4,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 144,
              decoration: BoxDecoration(
                color: isAnsEmpty ? null : EmoItem(emoNo: emoNo).getEmoColor(),
                border: Border.all(
                  width: 1.0,
                  color: EmoItem(emoNo: emoNo).getEmoStrokeColor(),
                ),
                borderRadius: BorderRadius.circular(5),
                gradient: isAnsEmpty
                    ? LinearGradient(
                        colors: [
                          EmoItem(emoNo: emoNo).getEmoGradientColor(),
                          Colors.white
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Text(
                          "Q.${index + 1}",
                          style: TextStyle(
                            color: EmoItem(emoNo: emoNo).getEmoTextColor(),
                            fontSize: 16,
                            fontFamily: '',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          qnaDataList[index].question,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: EmoItem(emoNo: emoNo).getEmoTextColor(),
                            fontSize: 16,
                            fontFamily: '',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 62),
                  WriteQnaBtn(
                    qnaDataService: qnaDataService,
                    index: index,
                    isAnsEmpty: isAnsEmpty,
                    emoNo: emoNo,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
