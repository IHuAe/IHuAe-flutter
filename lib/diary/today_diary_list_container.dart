import 'package:flutter/cupertino.dart';
import 'package:flutter_ihuae/services/diary_data_service.dart';
import 'package:provider/provider.dart';

import 'today_diary_item.dart';

class TodayDiaryListContainer extends StatefulWidget {
  const TodayDiaryListContainer({
    super.key,
    required this.dateID,
  });
  final int dateID;

  @override
  State<TodayDiaryListContainer> createState() =>
      _TodayDiaryListContainerState();
}

class _TodayDiaryListContainerState extends State<TodayDiaryListContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryDataService>(
        builder: (context, diaryDataService, child) {
      List<DiaryData> diaryDataList =
          diaryDataService.diaryDataMap[widget.dateID] ?? [];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '오늘의 기록',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A4A4A),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: 90, right: 0, left: 0),
              itemCount: diaryDataList.length,
              itemBuilder: (context, index) {
                return TodayDiaryItem(
                    diaryDataService: diaryDataService,
                    dateID: widget.dateID,
                    diaryIndex: index,
                    diaryData: diaryDataList[index]);
              },
            ),
          ),
        ],
      );
    });
  }
}
