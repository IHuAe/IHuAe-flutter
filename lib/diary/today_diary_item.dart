import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayDiaryItem extends StatelessWidget {
  const TodayDiaryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 88,
        margin: EdgeInsets.only(top: 0, bottom: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1.0,
              color: Color(0xFFECECEC),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "data",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7A7A7A),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("삭제");
                      },
                      child: Text(
                        "삭제",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "datadssfsfsdlksjlksdjflsdkfjlsjsdlfkdjslkjsddsdsfsdsfsfsdslkjl",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9A9A9A),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
