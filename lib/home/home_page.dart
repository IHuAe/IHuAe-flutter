import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/home/top_container.dart';
import 'package:flutter_ihuae/home/view_pager.dart';

// 첫번째 페이지
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarDataService>(
        builder: (context, calendarDataService, child) {
      return Container(
        color: const Color(0xFFF6F8FD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //디데이, 하루문답 컨테이너
            TopContainer(calendarDataService: calendarDataService),
            //이미지 카드
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 27.0),
                child: ViewPager(
                  dDay: calendarDataService.dDay,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
