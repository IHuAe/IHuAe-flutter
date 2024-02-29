import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ihuae/main.dart';

import 'chat_page.dart';

// 네번째 페이지
class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Title'),
        // include 태그로 추가되는 툴바를 이곳에 추가하세요
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Color(0xFFF6F8FD),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ListView.builder(
                      itemCount: 10, // 채팅 아이템 수에 맞게 조절하세요
                      itemBuilder: (context, index) {
                        return Text(""); //YourChatItemWidget();
                      },
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 16,
                    right: 4,
                    child: Container(
                      height: 47,
                      padding: EdgeInsets.fromLTRB(16, 16, 4, 17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        '이 곳은 충동적인 감정을 억제하기 위한 곳입니다.\n상대방에게 하고 싶은 말이 있다면, 이 곳에 써주세요.\n하루가 지나면, 당신의 말들은 사라집니다.',
                        style: TextStyle(
                          fontFamily: 'SpoqaHanSansNeoMedium',
                          color: Color(0xFFA8A8A8),
                          fontSize: 11,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 0,
                    child: Container(
                      height: 47,
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        'images/btn_expand.png',
                        width: 36,
                        height: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 58,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            color: Color(0xFFD8E0F3),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: '입력하세요',
                hintStyle: TextStyle(
                  fontFamily: 'SpoqaHanSansNeoMedium',
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Color(0xFFF8FAFF),
              ),
              maxLines: 1,
              maxLength: 800,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontFamily: 'SpoqaHanSansNeoMedium',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
