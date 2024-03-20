import 'package:flutter/material.dart';

import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:flutter_ihuae/calendar/calendar_item.dart';

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({
    super.key,
    required this.itemWidth,
    required this.calendarDataService,
    required this.calendarDataMap,
    required this.monthList,
    required this.currentPageIndex,
    required this.viewPagerController,
    required this.handleViewPagerChanged,
    required this.updateSelectedCalData,
  });

  final double itemWidth;
  final CalendarDataService calendarDataService;

  final Map calendarDataMap;
  final List<int> monthList;
  final int currentPageIndex;
  final PageController viewPagerController;
  final void Function(int) handleViewPagerChanged;
  final void Function(CalendarData) updateSelectedCalData;

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36),
      height: 340,
      child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: widget.viewPagerController,
          onPageChanged: widget.handleViewPagerChanged,
          itemCount: widget.calendarDataMap.length,
          itemBuilder: (BuildContext pageContext, int pageIndex) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  widget.calendarDataMap[widget.monthList[pageIndex]].length,
              itemBuilder: (BuildContext weekContext, int weekIndex) {
                return SizedBox(
                  height: 58,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget
                          .calendarDataMap[widget.monthList[pageIndex]]
                              [weekIndex]
                          .length,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((innerContext, innerIndex) {
                        return GestureDetector(
                          onTap: () {
                            if (widget
                                .calendarDataMap[widget.monthList[pageIndex]]
                                    [weekIndex][innerIndex]
                                .isEnabled) {
                              widget.updateSelectedCalData(
                                  widget.calendarDataMap[
                                          widget.monthList[pageIndex]]
                                      [weekIndex][innerIndex]);
                            }
                          },
                          child: CalendarItem(
                            itemWidth: (widget.itemWidth),
                            itemHeight: 58,
                            calendarData: widget.calendarDataMap[widget
                                .monthList[pageIndex]][weekIndex][innerIndex],
                          ),
                        );
                      })),
                );
              },
            );
          }),
    );
  }
}
