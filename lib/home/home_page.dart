import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                    "하루문답",
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
                          "오늘의 질문", //TODO 질문내용 데이터 연동
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
                          Fluttertoast.showToast(msg: "toast test");
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
