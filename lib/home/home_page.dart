import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ihuae/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../chat/chat_page.dart';

// 첫번째 페이지
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _ViewPagerState _viewPagerState = _ViewPagerState();
    ViewPager viewPager = ViewPager(viewPagerState: _viewPagerState);
    return Container(
      color: const Color(0xFFF6F8FD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //디데이, 하루문답 컨테이너
          Container(
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
              padding: const EdgeInsets.only(
                  top: 18, bottom: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "D-Day", //TODO 디데이 카운트
                        style: TextStyle(
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
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
                            fontFamily: 'SpoqaHanSansNeoBold',
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
                                  fontFamily: 'SpoqaHanSansNeoMedium',
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
                                      fontFamily: 'SpoqaHanSansNeoMedium',
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
          ),
          //이미지 카드
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 27.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 9, right: 15),
                    child: Image.asset(
                      'images/arr_left.png',
                      width: 32,
                      height: 48,
                    ),
                  ),
                  Expanded(
                    child: viewPager, // Container(child: const Placeholder()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 15, right: 9),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14159), // 180도 회전
                      child: Image.asset(
                        'images/arr_left.png',
                        width: 32,
                        height: 44,
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

class ViewPager extends StatefulWidget {
  const ViewPager({super.key, required this.viewPagerState});
  final _ViewPagerState viewPagerState;

  @override
  State<ViewPager> createState() {
    return viewPagerState;
  }
}

class _ViewPagerState extends State<ViewPager> with TickerProviderStateMixin {
  late PageController _viewPagerController;
  //late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _viewPagerController = PageController();
    //_tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _viewPagerController.dispose();
    //_tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView.builder(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: _viewPagerController,
          onPageChanged: _handleViewPagerChanged,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            int imageNum = index + 1;
            return Image.asset(
              'images/guide_card/guide_card_day$imageNum.png',
              fit: BoxFit.contain,
            );
          },
        ),
      ],
    );
  }

  void _handleViewPagerChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    //_tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    //_tabController.index = index;
    _viewPagerController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

/// Page indicator for desktop and web platforms.
///
/// On Desktop and Web, drag gesture for horizontal scrolling in a PageView is disabled by default.
/// You can defined a custom scroll behavior to activate drag gestures,
/// see https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag.
///
/// In this sample, we use a TabPageSelector to navigate between pages,
/// in order to build natural behavior similar to other desktop applications.
// class PageIndicator extends StatelessWidget {
//   const PageIndicator({
//     super.key,
//     required this.tabController,
//     required this.currentPageIndex,
//     required this.onUpdateCurrentPageIndex,
//     required this.isOnDesktopAndWeb,
//   });

//   final int currentPageIndex;
//   final TabController tabController;
//   final void Function(int) onUpdateCurrentPageIndex;
//   final bool isOnDesktopAndWeb;

//   @override
//   Widget build(BuildContext context) {
//     if (!isOnDesktopAndWeb) {
//       return const SizedBox.shrink();
//     }
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           IconButton(
//             splashRadius: 16.0,
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               if (currentPageIndex == 0) {
//                 return;
//               }
//               onUpdateCurrentPageIndex(currentPageIndex - 1);
//             },
//             icon: const Icon(
//               Icons.arrow_left_rounded,
//               size: 32.0,
//             ),
//           ),
//           TabPageSelector(
//             controller: tabController,
//             color: colorScheme.background,
//             selectedColor: colorScheme.primary,
//           ),
//           IconButton(
//             splashRadius: 16.0,
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               if (currentPageIndex == 2) {
//                 return;
//               }
//               onUpdateCurrentPageIndex(currentPageIndex + 1);
//             },
//             icon: const Icon(
//               Icons.arrow_right_rounded,
//               size: 32.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
