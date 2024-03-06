import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'SpoqaHanSansNeo',
          fontWeight: FontWeight.w500,
          color: Color(0xFF4A4A4A),
          fontSize: 16,
        ),
      ),
    );
  }
}
