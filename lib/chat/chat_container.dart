import 'package:flutter/material.dart';
import 'package:flutter_ihuae/chat/chat_item.dart';
import 'package:flutter_ihuae/chat/input_container.dart';
import 'package:flutter_ihuae/services/chat_data_service.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    super.key,
    required this.deviceHeight,
    required this.statusBarHeight,
    required this.chatDataService,
  });

  final double deviceHeight;
  final double statusBarHeight;
  final ChatDataService chatDataService;

  @override
  Widget build(BuildContext context) {
    List<Widget> chatItems = [];
    for (var i = 0; i < chatDataService.chatDataList.length; i++) {
      final chatData = chatDataService.chatDataList[i];
      chatItems.add(ChatItem(
        messageContent: chatData.content,
        index: i,
      ));
    }
    return SingleChildScrollView(
      child: SizedBox(
        height: deviceHeight - statusBarHeight - 50 /*타이틀바*/ - 69 /*바텀네비게이션*/,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding:
                      EdgeInsets.only(top: 64, bottom: 0, left: 0, right: 0),
                  child: Column(
                    children: chatItems,
                  ),
                ),
              ),
            ), //입력 영역
            InputContainer(chatDataService: chatDataService),
          ],
        ),
      ),
    );
  }
}
