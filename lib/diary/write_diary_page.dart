import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:flutter_ihuae/delete_dialog.dart';
import 'package:flutter_ihuae/services/diary_data_service.dart';

class WriteDiaryPage extends StatefulWidget {
  const WriteDiaryPage({
    super.key,
    required this.diaryData,
    required this.dateID,
    required this.diaryDataService,
    required this.index,
  });
  final DiaryDataService diaryDataService;
  final DiaryData diaryData;
  final int dateID;
  final int index;

  @override
  State<WriteDiaryPage> createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  String title = "";
  String content = "";
  bool isEditor = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    title = widget.diaryData.diaryTitle;
    content = widget.diaryData.diaryContent;
    isEditor = content.isEmpty;
    super.initState();
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteDialog(
          diaryDataService: widget.diaryDataService,
          dateID: widget.dateID,
          diaryIndex: widget.index,
          isDetailPage: true,
        );
      },
    );
  }

  void showConfirmDialog(BuildContext context, bool isTitle) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          content: Container(
            width: 280,
            height: 143,
            padding: EdgeInsets.only(top: 31, bottom: 25),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    "${isTitle ? "제목" : "내용"}을 입력해주세요.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4A4A4A)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 66,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "확인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4A4A4A)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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
          isEditor ? "일기 작성" : "나의 기록",
          style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 16,
              fontFamily: "SpoqaHanSansNeo",
              fontWeight: FontWeight.w500),
        ),
        actions: [
          if (!isEditor)
            GestureDetector(
              onTap: () {
                setState(() {
                  isEditor = true;
                });
              },
              child: Container(
                height: 49,
                padding:
                    EdgeInsets.only(top: 18, bottom: 16, left: 20, right: 10),
                child: Text(
                  "수정",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: "",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF8291E6),
                  ),
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              if (title.isEmpty) {
                showConfirmDialog(context, true);
                return;
              }
              if (content.isEmpty) {
                showConfirmDialog(context, false);
                return;
              }
              if (isEditor) {
                if (widget.index < 0) {
                  widget.diaryDataService
                      .createNewDiaryData(widget.dateID, title, content);
                } else {
                  widget.diaryDataService.updateDiaryData(
                      widget.dateID, widget.index, title, content);
                }
                Navigator.pop(context);
              } else {
                showDeleteDialog(context);
              }
            },
            child: Container(
              height: 49,
              padding:
                  EdgeInsets.only(top: 18, bottom: 16, left: 10, right: 20),
              child: Text(
                isEditor ? "작성 완료" : "삭제",
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
          //내용 컨테이너
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  //제목 컨테이너
                  TextFormField(
                    readOnly: !isEditor,
                    initialValue: title,
                    maxLength: 20,
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    style: TextStyle(
                      fontFamily: "SpoqaHanSansNeo",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color(0xFF4A4A4A),
                    ),
                    decoration: InputDecoration(
                      hintText: "제목 입력하기",
                      hintStyle: TextStyle(
                        fontFamily: "SpoqaHanSansNeo",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xFF888888),
                      ),
                      counterText: "",
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 23, bottom: 36),
                      child: Scrollbar(
                        controller: _scrollController,
                        child: TextFormField(
                          readOnly: !isEditor,
                          initialValue: content,
                          onChanged: (value) {
                            setState(() {
                              content = value;
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
                            .format(widget.diaryData.editDateTime),
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
                        "${content.length}/1000자",
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
