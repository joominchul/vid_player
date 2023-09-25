import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

int num = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  void onHeartPressed1() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Colors.white,
                  height: 300,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime date) {
                        setState(() {
                          firstDay = date;
                        });
                      })));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DDay(onHeartPressed: onHeartPressed1, daySet: firstDay),
              _CoupleImage()
            ],
          ),
        ));
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime daySet;

  _DDay({
    required this.onHeartPressed,
    required this.daySet,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    num = DateTime(now.year, now.month, now.day).difference(daySet).inDays;
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            "We&I",
            style: textTheme.headline1,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "아코 리코가 처음 집에 온 날",
            style: textTheme.bodyText1,
          ),
          Text(
            "${daySet.year}.${daySet.month}.${daySet.day}",
            style: textTheme.bodyText2,
          ),
          const SizedBox(
            height: 16,
          ),
          IconButton(
            onPressed: onHeartPressed,
            icon: Icon(Icons.favorite),
            iconSize: 60,
            color: Colors.red,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "D+$num",
            style: textTheme.bodyText2,
          )
        ],
      ),
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Image.asset(
        'asset/img/cat.jpg',
        height: MediaQuery.of(context).size.height / 2,
        //fit: BoxFit.fill,
      ),
    ));
  }
}
