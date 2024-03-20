import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ihuae/services/chat_data_service.dart';

class InputContainer extends StatefulWidget {
  const InputContainer({
    super.key,
    required this.chatDataService,
  });
  final ChatDataService chatDataService;

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
  late TextEditingController _controller;
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        controller: _controller,
        focusNode: myFocusNode,
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
          _controller.clear();
          myFocusNode.requestFocus();
        },
        onTapOutside: (event) {
          myFocusNode.unfocus();
        },
      ),
    );
  }
}
