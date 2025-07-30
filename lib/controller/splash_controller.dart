import 'dart:async';

import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/mixins/user_session.dart';
import 'package:finance_riza/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  LoginController loginController = Get.find<LoginController>();

  startSplashScreen() async {
    UserSession().getUser().then((value) {
      var duration = const Duration(seconds: 2);

      return Timer(duration, () {
        if (value == null) {
          Get.offNamed(RouterGenerator.routeLogin);
          // cartController.removeAllItemsCart();
          // catatanController.removeAllItemsCatatan();
          // pakaiToppingController.removeAllItemsFromPakaiTopping();
          // cartPemakaianController.removeAllItemsCartPemakaian();
        } else {
          loginController.userSession.value = value;
         
          // // Get.offNamed(RouterGenerator.routeHome);

          UserSession().deleteUser().then((value) {
            Get.offAllNamed(RouterGenerator.routeLogin);
            // cartController.removeAllItemsCart();
            // catatanController.removeAllItemsCatatan();
            // pakaiToppingController.removeAllItemsFromPakaiTopping();
            // cartPemakaianController.removeAllItemsCartPemakaian();
          });
        }
      });
    });
  }
}
