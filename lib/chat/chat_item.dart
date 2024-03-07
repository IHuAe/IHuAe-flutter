import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.messageContent,
    required this.index,
  });
  final String messageContent;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  constraints: BoxConstraints(maxWidth: 246),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFA2AFF8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Text(
                    messageContent,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFF8FAFF), // 텍스트 색상을 적절히 수정하세요
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
