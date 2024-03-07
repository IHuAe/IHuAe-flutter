import 'package:flutter/cupertino.dart';

import 'today_diary_item.dart';

class TodayDiaryListContainer extends StatelessWidget {
  const TodayDiaryListContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            itemCount: 5, // RecyclerView의 아이템 수에 맞게 조절하세요
            itemBuilder: (context, index) {
              return TodayDiaryItem();
            },
          ),
        ),
      ],
    );
  }
}
