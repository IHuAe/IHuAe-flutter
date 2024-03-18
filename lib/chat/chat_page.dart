import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_ihuae/chat/chat_item.dart';
import 'package:flutter_ihuae/services/chat_data_service.dart';
import 'package:flutter_ihuae/title_bar.dart';
import 'package:provider/provider.dart';

// 네번째 페이지
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isExpanded = false;
  List<ChatData> chatDataList = [];
  List<GlobalKey> globalkeys = [];

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double deviceHeight = deviceSize.height;
    return Consumer<ChatDataService>(
        builder: (context, chatDataService, child) {
      chatDataList = chatDataService.chatDataList;
      globalkeys = List.generate(chatDataList.length, (index) => GlobalKey());

      List<Widget> chatDataItems = [];
      for (var i = 0; i < chatDataList.length; i++) {
        final chatData = chatDataList[i];
        chatDataItems.add(ChatItem(
            key: globalkeys[i], messageContent: chatData.content, index: i));
      }
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
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: deviceHeight -
                              statusBarHeight -
                              50 /*타이틀바*/ -
                              57 /*TODO 바텀네비게이션*/,
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: chatDataItems,
                                    ),
                                  ),
                                ),
                                // child: ListView.builder(
                                //   padding: EdgeInsets.only(
                                //       top: 64, bottom: 0, left: 0, right: 0),
                                //   itemCount:
                                //       chatDataList.length, // 채팅 아이템 수에 맞게 조절하세요
                                //   itemBuilder: (context, index) {
                                //     return ChatItem(
                                //         key: globalkeys[index],
                                //         messageContent:
                                //             chatDataList[index].content,
                                //         index: index);
                                //   },
                                // ),
                              ), //입력 영역
                              InputContainer(
                                  globalkeys: globalkeys,
                                  chatDataService: chatDataService),
                            ],
                          ),
                        ),
                      ),
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

class InputContainer extends StatefulWidget {
  const InputContainer({
    super.key,
    required this.chatDataService,
    required this.globalkeys,
  });
  final ChatDataService chatDataService;
  final List<GlobalKey> globalkeys;

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color(0xFFD8E0F3),
    ),
  );
  String msgContent = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      color: Color(0xFFD8E0F3),
      child: TextFormField(
          onChanged: (val) {
            setState(() {
              msgContent = val;
            });
          },
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            counterText: '',
            hintText: '입력하세요',
            hintStyle: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 156, 156, 156),
              fontSize: 16,
            ),
            filled: true,
            fillColor: Color(0xFFF8FAFF),
            contentPadding: EdgeInsets.symmetric(horizontal: 14),
          ),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          maxLength: 800,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          style: TextStyle(
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w500,
            color: Color(0xFF777777),
            fontSize: 16,
          ),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            widget.chatDataService.createChatData(msgContent);

            setState(() {
              msgContent = "";
            });
            controller.clear();
            Scrollable.ensureVisible(
                widget
                    .globalkeys[widget.chatDataService.chatDataList.length - 1]
                    .currentContext!,
                alignment: 0.7,
                duration: const Duration(milliseconds: 350));
          }),
    );
  }
}

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

class GuideContainerHandler extends StatefulWidget {
  const GuideContainerHandler({
    super.key,
    required this.isExpanded,
    required this.isExpandedChanger,
  });
  final bool isExpanded;
  final void Function(bool) isExpandedChanger;
  @override
  State<StatefulWidget> createState() {
    return _GuideContainerHandlerState();
  }
}

class _GuideContainerHandlerState extends State<GuideContainerHandler> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isExpandedChanger(!widget.isExpanded);
      },
      child: Container(
        height: 47,
        width: 44,
        child: Transform(
          alignment: Alignment.center,
          transform: widget.isExpanded
              ? Matrix4.rotationX(3.14159)
              : Matrix4.rotationX(0), // 180도 회전,
          child: Image.asset(
            'images/btn_expand.png',
            width: 16,
            height: 12,
          ),
        ),
      ),
    );
  }
}
