import 'dart:convert';

import 'package:finance_riza/controller/save_login_controller.dart';
import 'package:finance_riza/mixins/user_session.dart';
import 'package:finance_riza/repository/login_repository.dart';
import 'package:finance_riza/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginController extends GetxController {
  var isObscured = true.obs;

  ProgressDialog progressDialog;
  var userSession = new Map<String, dynamic>().obs;

  // -------------------
  String username = "";
  String password = "";

  SaveLoginController saveLoginController = Get.find<SaveLoginController>();
  LoginRepository loginRepository = Get.find<LoginRepository>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void obsucureEvent() {
    if (isObscured == true) {
      isObscured(false);
    } else {
      isObscured(true);
    }
  }

  void initProgress(BuildContext context) {
    progressDialog = new ProgressDialog(context, isDismissible: false);
  }

  void login(var formKey, BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      // Show loading dialog
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyan[400],
          ),
        ),
        barrierDismissible: false,
      );

      print("Username .. $username");

      loginRepository.Login(username, password).then((value) {
        // Close loading dialog
        Get.back();

        var jsonDecode = json.decode(value);

        if (jsonDecode['message'] == "Login successful") {
          // Ambil token dan user
          String token = jsonDecode["token"] ?? "";
          Map<String, dynamic> user = jsonDecode["user"] ?? {};

          // Buat satu object session lengkap
          Map<String, dynamic> session = {
            "token": token,
            "id": user["id"] ?? 0,
            "username": user["username"] ?? "",
            "name": user["name"] ?? "",
            "email": user["email"] ?? "",
            "role": user["role"] ?? "",
            "is_login": true,
          };

          // Simpan ke local/session (ubah sesuai implementasi kamu)
          UserSession().saveUser(session).then((value) {
            userSession.value = value;

            // Arahkan ke halaman utama
            Get.offNamed(RouterGenerator.routeMenuDanaKu);

            // Simpan login jika perlu
            saveLoginController.checkAndAskToSaveLogin(username, password);
          });
        } else {
          // Login gagal
          Get.snackbar(
            "Login Gagal",
            jsonDecode["message"] ?? "Terjadi kesalahan",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }).catchError((err, track) {
        Get.back();
        Get.snackbar(
          "Kesalahan",
          "Terjadi kesalahan server",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        print("kesalahan login: $err");
        print("kesalahan login: $track");
      });
    }
  }
}
