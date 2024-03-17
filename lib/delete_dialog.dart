import 'package:flutter/material.dart';
import 'package:flutter_ihuae/diary/today_diary_item.dart';
import 'package:flutter_ihuae/services/diary_data_service.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.diaryDataService,
    required this.dateID,
    required this.diaryIndex,
  });

  final DiaryDataService diaryDataService;
  final int dateID;
  final int diaryIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "기록을 삭제하시겠습니까?",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF4A4A4A),
        ),
      ),
      actions: [
        // 취소 버튼
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "취소",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ),
        // 확인 버튼
        TextButton(
          onPressed: () {
            diaryDataService.deleteDiaryData(dateID, diaryIndex);
            Navigator.pop(context); // 팝업 닫기
          },
          child: Text(
            "삭제",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF000AFF),
            ),
          ),
        ),
      ],
    );
  }
}
