// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, unused_field, avoid_unnecessary_containers, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/controller/menu_controller.dart';
import 'package:finance_riza/style/styles.dart';
import 'package:finance_riza/ui_dana_ku/menu_dana_ku/aktivitas_dana_ku/aktivitas_dana_ku_screen.dart';
import 'package:finance_riza/ui_dana_ku/menu_dana_ku/profile_dana_ku/profile_dana_ku_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDanaKuScreen extends StatelessWidget {
  LoginController loginController;
  MenuController menuController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> list_widget = [
    AktivitasDanaKuScreen(),
  
    ProfileDanaKuScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    loginController = Get.find<LoginController>();
    menuController = Get.find<MenuController>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Obx(() => list_widget[menuController.currentIndex.value]),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Obx(
          () => CurvedNavigationBar(
              color: Colors.white,
              animationCurve: Curves.easeInOut,
              backgroundColor: AppStyles.colorDasar,
              index: menuController.currentIndex.value,
              height: 63,
              animationDuration: Duration(milliseconds: 500),
              onTap: (index) {
                menuController.changeIndex(index);
              },
              items: <Widget>[
                Container(
                  child: Icon(
                    Icons.assignment,
                    size: 20,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.account_circle,
                    size: 20,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
