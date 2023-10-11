
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2; //현재 민감도
  int number = 2; //주사위 숫자
  int ax = 0;
  int ay = 0;
  int az = 0;

  int ux = 1;
  int uy = 1;
  int uz = 1;

  int gx = 2;
  int gy = 2;
  int gz = 2;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    controller!.addListener(tabListener);
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   sense(threshold);
    // });
  }

  sense(double threshold) {
    accelerometerEvents.listen((event) {
      ax = event.x.toInt();
      ay = event.y.toInt();
      az = event.z.toInt();
    });
    // print("ac : $ax / $ay / $az");
    userAccelerometerEvents.listen((event) {
      ux = event.x.toInt();
      uy = event.y.toInt();
      uz = event.z.toInt();
    });
    print("ur : $ux / $uy / $uz");
    gyroscopeEvents.listen((event) {
      gx = event.x.toInt();
      gy = event.y.toInt();
      gz = event.z.toInt();
    });
    print("gy : $gx / $gy / $gz");

    if (ux + uy + uz + gx + gy + gz == threshold) {
      setState(() {
        onShake();
      });
    }
  }

  void onShake() {
    final rand = new Random();
    print("shake");
    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener() {
    setState(() {});
  }

  @override
  dispose() {
    controller!.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      // Container(
      //   child: Center(
      //     child: Text(
      //       'Tab1',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
      HomeScreen(number: number),
      // Container(
      //   child: Center(
      //     child: Text(
      //       'Tab2',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // )
      SettingsScreen(threshold: threshold, onThresholdChange: onThresholdChange)
    ];
  }

  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.edgesensor_high_outlined), label: '주사위'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
      ],
    );
  }
}
