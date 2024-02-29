import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 65,
            color: Colors.transparent, // 상단 공간을 포함한 빈 컨테이너
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  constraints: BoxConstraints(maxWidth: 246),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue, // 배경색을 적절히 수정하세요
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Your Content',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // 텍스트 색상을 적절히 수정하세요
                      fontFamily: 'SpoqaHanSansNeoMedium',
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
