import 'package:flutter/material.dart';

import 'package:flutter_ihuae/home/home_page.dart';
import 'package:flutter_ihuae/calendar/calendar_page.dart';
import 'package:flutter_ihuae/diary/diary_page.dart';
import 'package:flutter_ihuae/chat/chat_page.dart';
import 'package:flutter_ihuae/services/calendar_data_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<Map> emoList = [
  {
    "emoNo": 0,
    "emoIconImage": "images/emo_circle.png",
    "emoName": "",
  },
  {
    "emoNo": 1,
    "emoIconImage": "images/ic_emotion_calmness.png",
    "emoName": "평온"
  },
  {
    "emoNo": 2,
    "emoIconImage": "images/ic_emotion_dullness.png",
    "emoName": "무덤덤"
  },
  {
    "emoNo": 3,
    "emoIconImage": "images/ic_emotion_sadness.png",
    "emoName": "슬픔"
  },
  {"emoNo": 4, "emoIconImage": "images/ic_emotion_anger.png", "emoName": "분노"},
  {
    "emoNo": 5,
    "emoIconImage": "images/ic_emotion_satisfied.png",
    "emoName": "만족"
  },
  {
    "emoNo": 6,
    "emoIconImage": "images/ic_emotion_emptiness.png",
    "emoName": "공허함"
  },
];

late SharedPreferences prefs;
//late int dDay;
//late List<CalendarData> calendarDataList;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalendarDataService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IhuAe',
      theme: ThemeData(
        fontFamily: 'SpoqaHanSansNeo',
        primarySwatch: Colors.blue,
      ),
      home: BasePage(),
    );
  }
}

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  double _statusBarHeight = 0.0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CalendarPage(),
    DiaryPage(),
    ChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Consumer<CalendarDataService>(
        builder: (context, calendarDataService, child) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: _statusBarHeight),
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/tab_on_ic_home.png')),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/tab_on_ic_calendar.png')),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/tab_on_ic_diary.png')),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/tab_on_ic_chat.png')),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF8291E6),
          unselectedItemColor: Color(0xFFD9D9D9),
          onTap: _onItemTapped,
        ),
      );
    });
  }
}
