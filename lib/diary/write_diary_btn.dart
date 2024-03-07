import 'package:flutter/material.dart';

class WriteDiaryBtn extends StatelessWidget {
  const WriteDiaryBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Color(0xFF8291E6),
      onPressed: () {},
      child: Center(
        child: Text(
          "+",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
