import 'package:flutter/material.dart';

class GuideContainerHandler extends StatefulWidget {
  const GuideContainerHandler({
    super.key,
    required this.isExpanded,
    required this.isExpandedChanger,
  });
  final bool isExpanded;
  final void Function(bool) isExpandedChanger;
  @override
  State<StatefulWidget> createState() {
    return _GuideContainerHandlerState();
  }
}

class _GuideContainerHandlerState extends State<GuideContainerHandler> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isExpandedChanger(!widget.isExpanded);
      },
      child: SizedBox(
        height: 47,
        width: 44,
        child: Transform(
          alignment: Alignment.center,
          transform: widget.isExpanded
              ? Matrix4.rotationX(3.14159)
              : Matrix4.rotationX(0), // 180도 회전,
          child: Image.asset(
            'images/btn_expand.png',
            width: 16,
            height: 12,
          ),
        ),
      ),
    );
  }
}
