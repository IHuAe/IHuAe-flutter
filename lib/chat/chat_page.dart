import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ihuae/services/chat_data_service.dart';
import 'package:flutter_ihuae/title_bar.dart';
import 'package:flutter_ihuae/chat/guide_container.dart';
import 'package:flutter_ihuae/chat/guide_container_handler.dart';
import 'package:flutter_ihuae/chat/chat_container.dart';

// 네번째 페이지
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isExpanded = false;
  List<ChatData> chatDataList = [];

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double deviceHeight = deviceSize.height;
    return Consumer<ChatDataService>(
        builder: (context, chatDataService, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //타이틀바
            TitleBar(title: "감정 억제기"),
            Expanded(
              child: Container(
                color: Color(0xFFF6F8FD),
                child: Stack(
                  children: [
                    //메세지 말풍선 영역
                    Positioned.fill(
                      child: ChatContainer(
                          deviceHeight: deviceHeight,
                          statusBarHeight: statusBarHeight,
                          chatDataService: chatDataService),
                    ),
                    //가이드 텍스트 영역
                    Positioned(
                      top: 6,
                      left: 0,
                      right: 0,
                      child: GuideContainer(isExpanded: _isExpanded),
                    ),
                    //가이드 텍스트 영역 확장 핸들러
                    Positioned(
                      top: 6,
                      right: 0,
                      child: GuideContainerHandler(
                        isExpanded: _isExpanded,
                        isExpandedChanger: _isExpandedChanger,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _isExpandedChanger(bool isExpanded) {
    setState(() {
      _isExpanded = isExpanded;
    });
  }
}
