import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ihuae/services/emo_item.dart';
import 'package:flutter_ihuae/services/qna_data_service.dart';

class TodayQnAContainer extends StatelessWidget {
  const TodayQnAContainer({
    super.key,
    required this.index,
    required this.emoNo,
  });
  final int index;
  final int emoNo;

  @override
  Widget build(BuildContext context) {
    return Consumer<QnaDataService>(builder: (context, qnaDataService, child) {
      List<QnaData> qnaDataList = qnaDataService.qnaDataList;
      bool isAnsEmpty = qnaDataList[index].answer.isEmpty;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '오늘의 문답',
            style: TextStyle(
              fontFamily: 'SpoqaHanSansNeo',
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A4A4A),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Material(
            elevation: 4,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 144,
              decoration: BoxDecoration(
                color: isAnsEmpty ? null : EmoItem(emoNo: emoNo).getEmoColor(),
                border: Border.all(
                  width: 1.0,
                  color: EmoItem(emoNo: emoNo).getEmoStrokeColor(),
                ),
                borderRadius: BorderRadius.circular(5),
                gradient: isAnsEmpty
                    ? LinearGradient(
                        colors: [
                          EmoItem(emoNo: emoNo).getEmoGradientColor(),
                          Colors.white
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Text(
                          "Q.${index + 1}",
                          style: TextStyle(
                            color: EmoItem(emoNo: emoNo).getEmoTextColor(),
                            fontSize: 16,
                            fontFamily: '',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          qnaDataList[index].question,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: EmoItem(emoNo: emoNo).getEmoTextColor(),
                            fontSize: 16,
                            fontFamily: '',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 62),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WriteQnaPage(
                              index: index,
                              qnaData: qnaDataList[index],
                              qnaDataService: qnaDataService),
                        ),
                      );
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        isAnsEmpty ? "기록하기" : "내 답변\n보기",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: EmoItem(emoNo: emoNo).getEmoTextColor(),
                          fontSize: 12,
                          fontFamily: '',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class WriteQnaPage extends StatefulWidget {
  const WriteQnaPage({
    super.key,
    required this.index,
    required this.qnaData,
    required this.qnaDataService,
  });
  final int index;
  final QnaData qnaData;
  final QnaDataService qnaDataService;

  @override
  State<WriteQnaPage> createState() => _WriteQnaPageState();
}

class _WriteQnaPageState extends State<WriteQnaPage> {
  String ans = "";
  final ScrollController _scrollController = ScrollController();
  bool isEditor = false;
  @override
  void initState() {
    ans = widget.qnaData.answer;
    isEditor = ans.isEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "images/toolbar_btn_back.png",
            width: 7,
            height: 10,
          ),
        ),
        centerTitle: true,
        title: Text(
          isEditor ? "문답 작성" : "문답 보기",
          style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 16,
              fontFamily: "SpoqaHanSansNeo",
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (isEditor) {
                widget.qnaDataService.updateAnswer(widget.index, ans);
                Navigator.pop(context);
              } else {
                setState(() {
                  isEditor = true;
                });
              }
            },
            child: Container(
              width: 87,
              height: 49,
              padding:
                  EdgeInsets.only(top: 18, bottom: 16, left: 20, right: 20),
              child: Text(
                isEditor ? "작성 완료" : "수정",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF8291E6),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          //질문컨테이너
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
              border: Border(
                top: BorderSide(
                  color: Color(0xFFD9D9D9),
                  width: 1.0,
                ),
              ),
            ),
            child: Text("Q.${widget.index + 1}\n${widget.qnaData.question}"),
          ),
          //답변 컨테이너
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 23, bottom: 36),
                      child: Scrollbar(
                        controller: _scrollController,
                        child: TextFormField(
                          readOnly: !isEditor,
                          initialValue: widget.qnaData.answer,
                          onChanged: (value) {
                            setState(() {
                              ans = value;
                            });
                          },
                          maxLines: null,
                          maxLength: 1000,
                          style: TextStyle(
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF6D6D6D),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "당신의 이야기를 들려주세요.",
                            hintStyle: TextStyle(
                              fontFamily: 'SpoqaHanSansNeo',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFFC4C4C4),
                            ),
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isEditor)
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat('yyyy.MM.dd aa hh:mm')
                            .format(widget.qnaData.regDateTime),
                        style: TextStyle(
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  if (isEditor)
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${ans.length}/1000자",
                        style: TextStyle(
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
