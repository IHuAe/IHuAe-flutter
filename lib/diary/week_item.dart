import 'package:flutter/cupertino.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/services/emo_item.dart';

class WeekItem extends StatelessWidget {
  const WeekItem({
    super.key,
    required this.index,
    required this.calendarDataService,
  });

  final int index;
  final CalendarDataService calendarDataService;

  @override
  Widget build(BuildContext context) {
    int emoNum = calendarDataService.calendarDataList[index].todayEmo;

    return Row(
      children: [
        Container(
          height: 30,
          width: 40,
          child: Stack(
            children: [
              if (emoNum != 0)
                Positioned.fill(
                  child: Opacity(
                    opacity: (index == calendarDataService.dDay) ? 1.0 : 0.3,
                    child: Image.asset(
                      EmoItem(emoNo: emoNum).getEmoIconImage(),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: (index == calendarDataService.dDay)
                          ? FontWeight.w700
                          : FontWeight.w400,
                      fontSize: 15,
                      color: (index == calendarDataService.dDay)
                          ? Color(0xFF2D2D2D)
                          : Color(0xFF6D6D6D),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
