import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  late Timer _timer;
  bool _isRunning = true;
  String _button = 'stop';
  List<String> imageNameList = [
    "이런이 '앙'",
    "이런이 '밥 주세요'",
    "미아 '어림없지'",
    "미아 'HOLA HOLA'",
    "시현이 '너의 마음에 빵야'",
    "시현이 '훌라 훌라'",
    "아샤 '뀨우'",
    "아샤 '쒸익 쒸익'",
    "온다 '열불'",
    "온다 '한입만'",
    "이유 '취한 모습'",
    "이유 '화내지 마'"
  ];
  String imageName = "";

  void move() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      int? nextPage = pageController.page?.toInt();
      if (nextPage == null) {
        return;
      }
      if (nextPage == 11) {
        nextPage = 0;
      } else {
        nextPage++;
      }
      pageController.animateToPage(nextPage,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void initState() {
    super.initState();
    move();
  }

  Container makeView(int num) {
    String name = imageNameList[num - 1];
    return Container(
      child: Column(
        children: [
          TextButton(
            child: Text("$name", style: TextStyle(fontSize: 30, color: Colors.white)),
            onPressed: (){},
            style: TextButton.styleFrom(backgroundColor: Colors.cyan),
          ),
          Container(
            width: 50,
            height: 50,
          ),
          Image.asset('asset/img/$num.gif')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("에버글로우 짤", style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
            ),
            Flexible(
              child: Container(
                  child: PageView(
                      controller: pageController,
                      //children: [makeView(1),makeView(2),makeView(3),makeView(4),makeView(5),makeView(6),makeView(7),makeView(8),makeView(9),makeView(10),makeView(11),makeView(12)]
                      children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                          .map((num) => makeView(num))
                          .toList())),
            ),
            ElevatedButton(
                onPressed: () {
                  _isRunning = !_isRunning;
                  if (_isRunning == false) {
                    setState(() {
                      _button = "run";
                      _timer.cancel();
                    });
                  } else {
                    setState(() {
                      _button = "stop";
                      move();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(100, 50)),
                child: Text(
                  "$_button",
                  style: TextStyle(fontSize: 20, backgroundColor: Colors.blue),
                )),
            Container(
              width: 50,
              height: 50,
            )
          ],
        ));
  }
}
