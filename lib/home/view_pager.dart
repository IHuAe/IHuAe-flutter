import 'package:flutter/material.dart';

import 'package:flutter_ihuae/home/view_pager_swiping_btn.dart';

class ViewPager extends StatefulWidget {
  const ViewPager({super.key, required this.dDay});
  final int dDay;

  @override
  State<ViewPager> createState() {
    return _ViewPagerState();
  }
}

class _ViewPagerState extends State<ViewPager> with TickerProviderStateMixin {
  late PageController _viewPagerController;

  int _currentPageIndex = 0;
  int imageCardSize = 0;

  @override
  void initState() {
    super.initState();
    imageCardSize = widget.dDay + 1;
    _currentPageIndex = widget.dDay;
    _viewPagerController = PageController(initialPage: widget.dDay);
  }

  @override
  void dispose() {
    super.dispose();
    _viewPagerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_currentPageIndex > 0)
          ViewPagerSwipingBtn(
            currentPageIndex: _currentPageIndex,
            imageCardSize: imageCardSize,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isLeft: true,
          ),
        if (_currentPageIndex == 0) SizedBox(width: 56),
        Expanded(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _viewPagerController,
            onPageChanged: _handleViewPagerChanged,
            itemCount: imageCardSize,
            itemBuilder: (BuildContext context, int index) {
              int imageNum = index + 1;
              return Image.asset(
                'images/guide_card/guide_card_day$imageNum.png',
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        if (_currentPageIndex < imageCardSize - 1)
          ViewPagerSwipingBtn(
            currentPageIndex: _currentPageIndex,
            imageCardSize: imageCardSize,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isLeft: false,
          ),
        if (_currentPageIndex == imageCardSize - 1) SizedBox(width: 56),
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
