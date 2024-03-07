import 'package:flutter/material.dart';

import 'week_item.dart';

class WeekListContainer extends StatelessWidget {
  const WeekListContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              'D+DAY',
              style: TextStyle(
                fontFamily: 'SpoqaHanSansNeo',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 30,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 0),
              scrollDirection: Axis.horizontal,
              itemCount: 7, // RecyclerView의 아이템 수에 맞게 조절하세요
              itemBuilder: (context, index) {
                return WeekItem(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
