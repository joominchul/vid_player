import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensor/const/colors.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: backgroundColor,
    ),
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int ax = 0; //센서들 변수
  int ay = 0;
  int az = 0;

  int ux = 0;
  int uy = 0;
  int uz = 0;

  int gx = 0;
  int gy = 0;
  int gz = 0;

  int img_num = 1; //주사위 이미지 번호


  String inf="주사위를 굴려주세요."; //멘트

  late Timer timer;
  final rand = new Random();

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     sense();
    //   });
    // });
    userAccelerometerEvents.listen((event) {
      ux = event.x.toInt();
      uy = event.y.toInt();
      uz = event.z.toInt();
    });
    gyroscopeEvents.listen((event) {
      gx = event.x.toInt();
      gy = event.y.toInt();
      gz = event.z.toInt();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  sense() {
    aniImg(); //3초 동안 주사위 변환 애니메이션
    // accelerometerEvents.listen((event) {
    //   ax = event.x.toInt();
    //   ay = event.y.toInt();
    //   az = event.z.toInt();
    //
    // });
    // print("ac : $ax / $ay / $az");
    Future.delayed(Duration(seconds: 3), () { //3초 후 흔들림 임식
      userAccelerometerEvents.listen((event) {
        ux = event.x.toInt();
        uy = event.y.toInt();
        uz = event.z.toInt();
      });
      gyroscopeEvents.listen((event) {
        gx = event.x.toInt();
        gy = event.y.toInt();
        gz = event.z.toInt();
      });
      print("$ux $uy $uz / $gx $gy $gz");
      img_num = ux + uy + uz + gx + gy + gz; // 흔들림 값들을 더해서 주사위 값을 설정.
      timer.cancel(); //애니메이션 종료
      inf="굴린 결과";
      print(img_num);
      if (img_num <= 0) { // 값이 음수일 경우 양수로 변환
        img_num *= (-1);
      }
      if (img_num > 6) { //6 이상일 경우
        img_num = img_num % 6;
        if (img_num == 0) { //값이 0이 나올 경우 랜덤으로 표시.
          img_num = rand.nextInt(5) + 1;
        }
      }

      setState(() {});
    });
  }

  aniImg() { // 주사위 바뀌는 애니메이션
    inf="흔들어주세요.";
    img_num=0;
    timer = Timer.periodic(Duration(milliseconds: 450), (timer) {
      print("img : $img_num");
      if (img_num == 7) {
        timer.cancel();
      } else {
        setState(() {});
        img_num += 1;
      }
    });
  }

  Widget shake(int num) { //흔들었는지 안 흔들었는지 판단.
    if (num == 0) {
      return Text(
        "움직임이 감지되지 않았습니다.",
        style: TextStyle(color: primaryColor),
      );
    } else {
      return Image.asset('asset/img/$num.png');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(inf, style: TextStyle(color: primaryColor),),
            SizedBox(
              height: 30,
            ),
            shake(img_num),
            SizedBox(
              height: 30,
            ),
            Text(
              "숫자: $img_num",
              style: TextStyle(color: primaryColor),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: sense,
                child: Text(
                  '주사위 굴리기',
                  style: TextStyle(color: primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
