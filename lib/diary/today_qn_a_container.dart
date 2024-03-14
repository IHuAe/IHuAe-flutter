import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';
import 'package:flutter_ihuae/services/qna_data_service.dart';
import 'package:provider/provider.dart';

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
                border: Border.all(
                  width: 1.0,
                  color: emoList[emoNo]['emoColor'],
                ),
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [emoList[emoNo]['emoColor'], Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
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
                            color: emoList[emoNo]['emoTextColor'],
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
                            color: emoList[emoNo]['emoTextColor'],
                            fontSize: 16,
                            fontFamily: '',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 62),
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      qnaDataList[index].answer.isEmpty ? "기록하기" : "내 답변\n보기",
                      style: TextStyle(
                        color: emoList[emoNo]['emoTextColor'],
                        fontSize: 12,
                        fontFamily: '',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
