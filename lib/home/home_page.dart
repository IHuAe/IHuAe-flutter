import 'package:flutter/material.dart';

import 'package:flutter_ihuae/main.dart';

// 첫번째 페이지
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF6F8FD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //디데이, 하루문답 컨테이너
          TopContainer(),
          //이미지 카드
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 27.0),
              child: ViewPager(),
            ),
          ),
        ],
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 169,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "D-Day", //TODO 디데이 카운트
                  style: TextStyle(
                    fontFamily: 'SpoqaHanSansNeo',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8291E6),
                    fontSize: 24,
                  ),
                ),
                Expanded(
                  child: Text(
                    "오늘의 기분을 표현해보세요",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8291E6),
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Image.asset(
                  'images/emo_circle.png', //TODO 유저가 설정한 기분 아이콘 설정
                  width: 27,
                  height: 27,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "오늘의 기분",
                    style: TextStyle(
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8291E6),
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "오늘의 기분을 기록해보세요.", //TODO 질문내용 데이터 연동
                          style: TextStyle(
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8291E6),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //TODO 기록하기 눌렀을 때, 기록 다이얼로그 팝업
                          //Fluttertoast.showToast(msg: "toast test");
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return WriteEmoDialog();
                            },
                          );
                        },
                        child: Container(
                          width: 82,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFF8996F3),
                          ),
                          child: const Center(
                            child: Text(
                              "기록하기",
                              style: TextStyle(
                                fontFamily: 'SpoqaHanSansNeo',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WriteEmoDialog extends StatelessWidget {
  const WriteEmoDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.6),
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 19),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "images/ic_cancel.png",
                        width: 17,
                        height: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11),
                Text(
                  "오늘은 어떤 기분이 드나요?",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'SpoqaHanSansNeo',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                SizedBox(height: 25),
                EmoGridContainer(),
                SizedBox(height: 37),
                Card(
                  elevation: 0,
                  shadowColor: Colors.white,
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1.0,
                        color: Color(0xFFB3B3B3),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      maxLength: 1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          counterText: '',
                          hintText: '추가로 느끼는 감정을 작성해보세요',
                          hintStyle: TextStyle(
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFFB3B3B3),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 23),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 82,
                    height: 27,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Color(0xFF8291E6),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        "선택완료",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8291E6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmoGridContainer extends StatelessWidget {
  const EmoGridContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: (13 / 15),
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 7),
        crossAxisSpacing: 36,
        mainAxisSpacing: 12,
        crossAxisCount: 3,
        children: <Widget>[
          EmoGridItem(emoImage: "images/ic_emotion_calmness.png", emoNM: "평온"),
          EmoGridItem(emoImage: "images/ic_emotion_dullness.png", emoNM: "무덤덤"),
          EmoGridItem(emoImage: "images/ic_emotion_sadness.png", emoNM: "슬픔"),
          EmoGridItem(emoImage: "images/ic_emotion_anger.png", emoNM: "분노"),
          EmoGridItem(emoImage: "images/ic_emotion_satisfied.png", emoNM: "만족"),
          EmoGridItem(
              emoImage: "images/ic_emotion_emptiness.png", emoNM: "공허함"),
        ],
      ),
    );
  }
}

class EmoGridItem extends StatelessWidget {
  const EmoGridItem({
    super.key,
    required this.emoImage,
    required this.emoNM,
  });
  final String emoImage;
  final String emoNM;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            padding:
                const EdgeInsets.only(top: 9, bottom: 5, left: 9, right: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  emoImage,
                  width: 40,
                  height: 40,
                ),
                Text(
                  emoNM,
                  style: TextStyle(
                    fontFamily: 'SpoqaHanSansNeo',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(130, 145, 230, 0.1),
              border: Border.all(
                width: 2,
                color: Color(0xFF8291E6),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}

class ViewPager extends StatefulWidget {
  const ViewPager({super.key});

  @override
  State<ViewPager> createState() {
    return _ViewPagerState();
  }
}

class _ViewPagerState extends State<ViewPager> with TickerProviderStateMixin {
  late PageController _viewPagerController;

  int _currentPageIndex = 0;
  int _imageCardSize = 3; //TODO 카드 갯수 설정, 디데이 별로 달라짐.

  @override
  void initState() {
    super.initState();
    _viewPagerController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _viewPagerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ViewPagerSwipingBtn(
          currentPageIndex: _currentPageIndex,
          imageCardSize: _imageCardSize,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          isLeft: true,
        ),
        Expanded(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _viewPagerController,
            onPageChanged: _handleViewPagerChanged,
            itemCount: _imageCardSize,
            itemBuilder: (BuildContext context, int index) {
              int imageNum = index + 1;
              return Image.asset(
                'images/guide_card/guide_card_day$imageNum.png',
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        ViewPagerSwipingBtn(
          currentPageIndex: _currentPageIndex,
          imageCardSize: _imageCardSize,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          isLeft: false,
        ),
      ],
    );
  }

  void _handleViewPagerChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _viewPagerController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class ViewPagerSwipingBtn extends StatelessWidget {
  const ViewPagerSwipingBtn({
    super.key,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isLeft,
    required this.imageCardSize,
  });

  final bool isLeft;
  final int currentPageIndex;
  final int imageCardSize;
  final void Function(int) onUpdateCurrentPageIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLeft) {
          if (currentPageIndex <= 0) return;

          int preIndex = currentPageIndex - 1;
          onUpdateCurrentPageIndex(preIndex);
        } else {
          if (currentPageIndex >= imageCardSize - 1) return;

          int preIndex = currentPageIndex + 1;
          onUpdateCurrentPageIndex(preIndex);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: (isLeft ? 9 : 15),
            right: (isLeft ? 15 : 9)),
        child: Transform(
          alignment: Alignment.center,
          transform: isLeft
              ? Matrix4.rotationY(0)
              : Matrix4.rotationY(3.14159), // 180도 회전
          child: Image.asset(
            'images/arr_left.png',
            width: 32,
            height: 48,
          ),
        ),
      ),
    );
  }
}
