import 'dart:async';

import 'package:flutter/material.dart';

import 'list_screen.dart';
import 'package:get/get.dart';
class SpaceScreen extends StatefulWidget {
  const SpaceScreen({Key? key}) : super(key: key);

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  @override
  void initState() {
      Timer(Duration(seconds: 3), () {
        Get.to(ListScreen());
      });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIlJr3bkOJgguI2XKfGe-rVgppvpTTJnnv8_gK1zoWgiLQPLm6k5qpz7_F1ddqh8Fb9d4&usqp=CAU"))
          ),
        ),
      ),
    );
  }
}
