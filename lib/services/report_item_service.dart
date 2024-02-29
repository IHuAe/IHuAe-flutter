import 'package:flutter/material.dart';

import 'package:flutter_ihuae/main.dart';

// Memo 데이터의 형식을 정해줍니다. 추후 isPinned, updatedAt 등의 정보도 저장할 수 있습니다.
class ReportItem {
  ReportItem({
    required this.content,
  });

  String content;
}

// Memo 데이터는 모두 여기서 관리
class ReportItemService extends ChangeNotifier {
  List<ReportItem> reportItems = [
    ReportItem(content: '장보기 목록: 사과, 양파'), // 더미(dummy) 데이터
    ReportItem(content: '새 메모'), // 더미(dummy) 데이터
  ];
}
