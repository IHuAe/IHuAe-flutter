import 'package:flutter/material.dart';
import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/services/emo_item.dart';

import 'package:flutter_ihuae/home/write_emo_dialog.dart';

class TopContainer extends StatefulWidget {
  const TopContainer({
    super.key,
    required this.calendarDataService,
  });

  final CalendarDataService calendarDataService;

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    int dDay = widget.calendarDataService.dDay;
    List<CalendarData> calendarDataList =
        widget.calendarDataService.calendarDataList;
    int todayEmoNum = calendarDataList[dDay].todayEmo;

    return Container(
      height: 169 + statusBarHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: statusBarHeight),
            Row(
              children: [
                Text(
                  dDay < widget.calendarDataService.maxDayCnt - 1
                      ? "D+${dDay + 1}"
                      : "D+Day",
                  style: TextStyle(
                    fontFamily: 'SpoqaHanSansNeo',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8291E6),
                    fontSize: 24,
                  ),
                ),
                Expanded(
                  child: Text(
                    EmoItem(emoNo: todayEmoNum).getEmoDescription(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8291E6),
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Image.asset(
                  EmoItem(emoNo: todayEmoNum).getEmoIconImage(),
                  width: 27,
                  height: 27,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "오늘의 기분",
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8291E6),
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "오늘의 기분을 기록해보세요.",
                          style: TextStyle(
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8291E6),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return WriteEmoDialog(
                                calendarDataService: widget.calendarDataService,
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 82,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFF8996F3),
                          ),
                          child: const Center(
                            child: Text(
                              "기록하기",
                              style: TextStyle(
                                fontFamily: 'SpoqaHanSansNeo',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
