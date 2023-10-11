import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MaterialApp(
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

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        sense();
      });
    });

  }

  sense(){
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ax: $ax"),
            Text("ay: $ay"),
            Text("az: $az"),
            SizedBox(height: 30,),
            Text("ux: $ux"),
            Text("uy: $uy"),
            Text("uz: $uz"),
            SizedBox(height: 30,),
            Text("gx: $gx"),
            Text("gy: $gy"),
            Text("gz: $gz"),
          ],
        ),
      ),
    );
  }
}
