import 'package:flutter/cupertino.dart';

class WeekItem extends StatelessWidget {
  const WeekItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 40,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "images/ic_emotion_sadness.png", //TODO 유저가 설정한 이미지로
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    "30", //일 수 맞춰서
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF6D6D6D),
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
