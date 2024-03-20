import 'package:flutter/material.dart';

import 'package:flutter_ihuae/home/emo_grid_item.dart';

class EmoGridContainer extends StatefulWidget {
  const EmoGridContainer({
    super.key,
    required this.todayEmo,
    required this.clickEmoGridItem,
  });
  final int todayEmo;
  final void Function(int) clickEmoGridItem;

  @override
  State<EmoGridContainer> createState() => _EmoGridContainerState();
}

class _EmoGridContainerState extends State<EmoGridContainer> {
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
          EmoGridItem(
            emoNo: 1,
            selectedEmo: widget.todayEmo,
            clickEmoGridItem: widget.clickEmoGridItem,
          ),
          EmoGridItem(
            emoNo: 2,
            selectedEmo: widget.todayEmo,
            clickEmoGridItem: widget.clickEmoGridItem,
          ),
          EmoGridItem(
            emoNo: 3,
            selectedEmo: widget.todayEmo,
            clickEmoGridItem: widget.clickEmoGridItem,
          ),
          EmoGridItem(
            emoNo: 4,
            selectedEmo: widget.todayEmo,
            clickEmoGridItem: widget.clickEmoGridItem,
          ),
          EmoGridItem(
            emoNo: 5,
            selectedEmo: widget.todayEmo,
            clickEmoGridItem: widget.clickEmoGridItem,
          ),
          EmoGridItem(
            emoNo: 6,
            selectedEmo: widget.todayEmo,
            clickEmoGridItem: widget.clickEmoGridItem,
          ),
        ],
      ),
    );
  }
}
