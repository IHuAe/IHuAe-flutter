import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_ihuae/services/diary_data_service.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.diaryDataService,
    required this.dateID,
    required this.diaryIndex,
    required this.isDetailPage,
  });

  final DiaryDataService diaryDataService;
  final int dateID;
  final int diaryIndex;
  final bool isDetailPage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
      content: Container(
        width: 280,
        height: 143,
        padding: EdgeInsets.only(top: 31, bottom: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Text(
                "기록을 삭제하시겠습니까?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 취소 버튼
                Container(
                  height: 40,
                  width: 66,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
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
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 34),
                    child: Image.asset("images/delete_dialog_btn_bar.png")),
                // 확인 버튼
                Container(
                  height: 40,
                  width: 66,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      diaryDataService.deleteDiaryData(dateID, diaryIndex);
                      Navigator.pop(context); // 팝업 닫기
                      if (isDetailPage) {
                        Navigator.pop(context); // 뷰어에서 삭제시 팝업 한 번 더 닫기
                      }
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
