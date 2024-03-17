import 'package:flutter/material.dart';
import 'package:flutter_ihuae/diary/write_diary_page.dart';
import 'package:flutter_ihuae/services/diary_data_service.dart';
import 'package:provider/provider.dart';

class WriteDiaryBtn extends StatefulWidget {
  const WriteDiaryBtn({
    super.key,
    required this.dateID,
    required this.diaryDataService,
  });
  final int dateID;
  final DiaryDataService diaryDataService;

  @override
  State<WriteDiaryBtn> createState() => _WriteDiaryBtnState();
}

class _WriteDiaryBtnState extends State<WriteDiaryBtn> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Color(0xFF8291E6),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WriteDiaryPage(
              diaryDataService: widget.diaryDataService,
              dateID: widget.dateID,
              diaryData: DiaryData(
                  diaryTitle: '',
                  diaryContent: '',
                  editDateTime: DateTime.now()),
              index: -1,
            ),
          ),
        );
      },
      child: Center(
        child: Text(
          "+",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
