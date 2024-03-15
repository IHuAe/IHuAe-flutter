import 'package:flutter/material.dart';
import 'package:flutter_ihuae/services/diary_data_service.dart';
import 'package:provider/provider.dart';

class WriteDiaryBtn extends StatefulWidget {
  const WriteDiaryBtn({
    super.key,
    required this.dateID,
  });
  final int dateID;

  @override
  State<WriteDiaryBtn> createState() => _WriteDiaryBtnState();
}

class _WriteDiaryBtnState extends State<WriteDiaryBtn> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Color(0xFF8291E6),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WriteDiaryPage(
              dateID: widget.dateID,
              diaryData: DiaryData(diaryTitle: '', diaryContent: ''),
            ),
          ),
        );
      },
      child: Center(
        child: Text(
          "+",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'SpoqaHanSansNeo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class WriteDiaryPage extends StatefulWidget {
  const WriteDiaryPage({
    super.key,
    required this.diaryData,
    required this.dateID,
  });
  final DiaryData diaryData;
  final int dateID;

  @override
  State<WriteDiaryPage> createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  String title = "";
  String content = "";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    content = widget.diaryData.diaryContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryDataService>(
        builder: (context, diaryDataService, child) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          centerTitle: true,
          title: Text(
            "일기 작성",
            style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 16,
                fontFamily: "SpoqaHanSansNeo",
                fontWeight: FontWeight.w500),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                if (title.isEmpty) return;
                if (content.isEmpty) return;
                diaryDataService.createNewDiaryData(
                    widget.dateID, title, content);
                Navigator.pop(context);
              },
              child: Container(
                width: 87,
                height: 49,
                padding:
                    EdgeInsets.only(top: 18, bottom: 16, left: 20, right: 20),
                child: Text(
                  "작성 완료",
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
    });
  }
}
