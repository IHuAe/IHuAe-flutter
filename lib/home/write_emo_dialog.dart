import 'package:flutter/material.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/home/write_emo_dialog_grid_container.dart';

class WriteEmoDialog extends StatefulWidget {
  const WriteEmoDialog({
    super.key,
    required this.calendarDataService,
  });

  final CalendarDataService calendarDataService;

  @override
  State<WriteEmoDialog> createState() => _WriteEmoDialogState();
}

class _WriteEmoDialogState extends State<WriteEmoDialog> {
  int index = 0;
  late CalendarData calendarData;
  int _todayEmo = 0;
  String _todayEmoContent = "";
  @override
  void initState() {
    index = widget.calendarDataService.dDay;
    calendarData = widget.calendarDataService.calendarDataList[index];
    _todayEmo = calendarData.todayEmo;
    _todayEmoContent = calendarData.todayEmoContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 19),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "images/ic_cancel.png",
                        width: 17,
                        height: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11),
                Text(
                  "오늘은 어떤 기분이 드나요?",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'SpoqaHanSansNeo',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                SizedBox(height: 25),
                WriteEmoDialogGridContainer(
                  todayEmo: _todayEmo,
                  clickEmoGridItem: _clickEmoGridItem,
                ),
                SizedBox(height: 37),
                Card(
                  elevation: 0,
                  shadowColor: Colors.white,
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1.0,
                        color: Color(0xFFB3B3B3),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      initialValue: _todayEmoContent,
                      onChanged: (value) {
                        _todayEmoContent = value;
                      },
                      maxLength: 100,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          counterText: '',
                          hintText: '추가로 느끼는 감정을 작성해보세요',
                          hintStyle: TextStyle(
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFFB3B3B3),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 23),
                GestureDetector(
                  onTap: () {
                    widget.calendarDataService
                        .updateTodayEmo(index, _todayEmo, _todayEmoContent);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 82,
                    height: 27,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Color(0xFF8291E6),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        "선택완료",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8291E6),
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
    );
  }

  void _clickEmoGridItem(int pos) {
    setState(() {
      _todayEmo = pos;
    });
  }
}
