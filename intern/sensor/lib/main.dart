import 'dart:async';

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
  int ax = 0;
  int ay = 0;
  int az = 0;

  int ux = 1;
  int uy = 1;
  int uz = 1;

  int gx = 2;
  int gy = 2;
  int gz = 2;

  int img_num = 1;

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     sense();
    //   });
    // });
  }

  sense() {
    // accelerometerEvents.listen((event) {
    //   ax = event.x.toInt();
    //   ay = event.y.toInt();
    //   az = event.z.toInt();
    //
    // });
    // print("ac : $ax / $ay / $az");
    Future.delayed(Duration(seconds: 3), () {
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
      img_num = ux + uy + uz + gx + gy + gz;

      print(img_num);
      if (img_num <= 0) {
        img_num *= (-1);
      }
      if (img_num > 6) {
        img_num = img_num % 6;
      }

      setState(() {});
    });
  }

  shake(int num) {
    if (num == 0) {
      Text(
        "움직임이 감지되지 않았습니다.",
        style: TextStyle(color: primaryColor),
      );
    } else {
      Image.asset('asset/img/$num.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/img/$img_num.png'),
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
                  style: TextStyle(
                      color: primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
