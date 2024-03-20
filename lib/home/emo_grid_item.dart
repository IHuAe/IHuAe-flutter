import 'package:flutter/material.dart';
import 'package:flutter_ihuae/services/emo_item.dart';

class EmoGridItem extends StatelessWidget {
  const EmoGridItem({
    super.key,
    required this.emoNo,
    required this.selectedEmo,
    required this.clickEmoGridItem,
  });

  final int emoNo;
  final int selectedEmo;
  final void Function(int) clickEmoGridItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clickEmoGridItem(emoNo);
      },
      child: Stack(
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
                    EmoItem(emoNo: emoNo).getEmoIconImage(),
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    EmoItem(emoNo: emoNo).getEmoName(),
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
          if (selectedEmo == emoNo)
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
      ),
    );
  }
}
