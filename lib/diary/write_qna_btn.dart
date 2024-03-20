import 'package:flutter/material.dart';

import 'package:flutter_ihuae/diary/write_qna_page.dart';
import 'package:flutter_ihuae/services/emo_item.dart';
import 'package:flutter_ihuae/services/qna_data_service.dart';

class WriteQnaBtn extends StatelessWidget {
  const WriteQnaBtn({
    super.key,
    required this.qnaDataService,
    required this.index,
    required this.isAnsEmpty,
    required this.emoNo,
  });

  final QnaDataService qnaDataService;
  final int index;

  final bool isAnsEmpty;
  final int emoNo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WriteQnaPage(
                index: index,
                qnaData: qnaDataService.qnaDataList[index],
                qnaDataService: qnaDataService),
          ),
        );
      },
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Text(
          isAnsEmpty ? "기록하기" : "내 답변\n보기",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: EmoItem(emoNo: emoNo).getEmoTextColor(),
            fontSize: 12,
            fontFamily: '',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
