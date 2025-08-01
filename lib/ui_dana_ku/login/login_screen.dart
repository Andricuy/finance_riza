// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/controller/save_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finance_riza/style/styles.dart';
import 'package:finance_riza/style/logo.dart';



class LoginScreen extends StatelessWidget {

  SaveLoginController saveLoginController;

  LoginController loginController;

  var formKey = GlobalKey<FormState>();

  final Color darkGreen = AppStyles.colorPrimary;
  final Color lightGreen = AppStyles.colorAccent;

  @override
  Widget build(BuildContext context) {
    saveLoginController = Get.find<SaveLoginController>();
    loginController = Get.find<LoginController>();
    loginController.initProgress(context);
    saveLoginController.loadSavedLogins();

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppStyles.colorAccent.withOpacity(0.15),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dan ornamen
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: DollarLogo(size: 90),
                ),
                // Card Form
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Selamat Datang",
                          style: theme.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppStyles.colorPrimary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Silakan login untuk melanjutkan",
                          style: theme.textTheme.bodyText2?.copyWith(color: AppStyles.colorPrimary.withOpacity(0.75)),
                        ),
                        SizedBox(height: 26),

                        // Username
                        Container(
                          decoration: BoxDecoration(
                            color: AppStyles.colorAccent.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: TextFormField(
                            controller: saveLoginController.usernameController,
                            onSaved: (String value) {
                              loginController.username = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Username wajib diisi";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15, color: AppStyles.colorPrimary),
                            decoration: InputDecoration(
                              hintText: "Username",
                              prefixIcon: Icon(Icons.account_circle, color: AppStyles.colorPrimary),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.arrow_drop_down, color: AppStyles.colorPrimary),
                                onPressed: () {
                                  saveLoginController.showSavedLogins();
                                },
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                            ),
                          ),
                        ),

                        SizedBox(height: 18),

                        // Password
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              color: AppStyles.colorAccent.withOpacity(0.16),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: TextFormField(
                              controller: saveLoginController.passwordController,
                              onSaved: (String value) {
                                loginController.password = value;
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Password wajib diisi";
                                }
                                return null;
                              },
                              style: TextStyle(fontSize: 15, color: AppStyles.colorPrimary),
                              obscureText: loginController.isObscured.value,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock, color: AppStyles.colorPrimary),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    loginController.isObscured.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppStyles.colorPrimary,
                                  ),
                                  onPressed: () {
                                    loginController.obsucureEvent();
                                  },
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 26),

                        // Tombol Login
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppStyles.colorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () async {
                              Get.back();
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                loginController.login(formKey, context);
                              } else {
                                print("Form not valid");
                              }
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "© 2025 Yayasan ADZ-DZURRIYAT",
                  style: theme.textTheme.caption?.copyWith(color: AppStyles.colorPrimary.withOpacity(0.60)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}