import 'package:flutter/material.dart';

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
