import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/diary/d_day_item.dart';

class DDayListContainer extends StatefulWidget {
  const DDayListContainer({
    super.key,
    required this.setSelectedDayPos,
    required this.globalkeys,
  });
  final void Function(int) setSelectedDayPos;
  final List<GlobalKey> globalkeys;

  @override
  State<DDayListContainer> createState() => _DDayListContainerState();
}

class _DDayListContainerState extends State<DDayListContainer> {
  ScrollController weekItemListController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarDataService>(
        builder: (context, calendarDataService, child) {
      return Container(
        margin: EdgeInsets.only(top: 6),
        padding: EdgeInsets.only(top: 11, bottom: 20),
        decoration: BoxDecoration(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'D+${calendarDataService.dDay + 1}',
                style: TextStyle(
                  fontFamily: 'SpoqaHanSansNeo',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 30,
              child: ListView.builder(
                controller: weekItemListController,
                scrollDirection: Axis.horizontal,
                itemCount: calendarDataService
                    .calendarDataList.length, // RecyclerView의 아이템 수에 맞게 조절하세요
                itemBuilder: (context, index) {
                  return GestureDetector(
                    key: widget.globalkeys[index],
                    onTap: () {
                      if (index <= calendarDataService.dDay) {
                        widget.setSelectedDayPos(index);
                      }
                    },
                    child: DDayItem(
                      calendarDataService: calendarDataService,
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
