import 'package:flutter/material.dart';

class GuideContainer extends StatefulWidget {
  const GuideContainer({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  State<GuideContainer> createState() => _GuideContainerState();
}

class _GuideContainerState extends State<GuideContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.isExpanded ? 87 : 47,
      padding: EdgeInsets.fromLTRB(16, 16, 4, 17),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      duration: Duration(milliseconds: 100),
      child: Text(
        '이 곳은 충동적인 감정을 억제하기 위한 곳입니다.\n상대방에게 하고 싶은 말이 있다면, 이 곳에 써주세요.\n하루가 지나면, 당신의 말들은 사라집니다.',
        style: TextStyle(
          fontFamily: 'SpoqaHanSansNeo',
          fontWeight: FontWeight.w500,
          color: Color(0xFFA8A8A8),
          fontSize: 11,
          height: 1.5,
        ),
      ),
    );
  }
}
