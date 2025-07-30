// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:finance_riza/controller/splash_controller.dart';
import 'package:finance_riza/ui_dana_ku/widget/fadeanimation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget {
  SplashController splashController;
  @override
  Widget build(BuildContext context) {
    splashController = Get.find<SplashController>();
    splashController.startSplashScreen();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeAnimation(
                1.4,
                Container(
                  child: FadeAnimation(
                    1.4,
                    Image.asset(
                      'assets/img/logo_splash.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
