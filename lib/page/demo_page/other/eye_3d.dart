import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:sensors/sensors.dart';



const int duration = 16 * 12;

class Eye3dState extends PageState {

  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late Size size;

  double x = 0;
  double y = 0;

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) async {
          setState(() {
            x = event.x * 2.5;
            y = event.y * 1.8;
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: size.width, height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                    top: y - 40,
                    right: x - 10,
                    duration: Duration(milliseconds: duration),
                    child: _bottom()),
                Positioned(
                    child: _middle()),
                AnimatedPositioned(
                    bottom: y ,
                    left: x + size.width / 3,
                    duration: Duration(milliseconds: duration),
                    child: _top()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottom() {
    return Container(
      width: size.width+60,height: 250,
      child: Image.asset('assets/images/bg.png',fit: BoxFit.fill,),
    );
  }

  Widget _middle() {
    return Text('悄悄滴进村，打枪滴不要',style: TextStyle(fontSize: 22),);
  }

  Widget _top() {
    return Container(
      width: 100, height: 100,
      child: Image.asset('assets/images/car.png',fit: BoxFit.fill),
    );
  }


}