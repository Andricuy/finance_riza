// ignore_for_file: prefer_const_constructors

import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/mixins/user_session.dart';
import 'package:finance_riza/routes.dart';
import 'package:finance_riza/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileDanaKuScreen extends StatelessWidget {
  LoginController loginController;

  final Color darkGreen = AppStyles.colorDasar;
  final Color lightGreen = Color(0xFFA3C78D);

  @override
  Widget build(BuildContext context) {
    loginController = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: lightGreen.withOpacity(0.07),
      body: Stack(
        children: [
          // HEADER background
          Container(
            height: 150, // lebih pendek
            decoration: BoxDecoration(
              color: darkGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: darkGreen.withOpacity(0.09),
                  blurRadius: 13,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
          // BODY
          Column(
            children: [
              // Overlap Card profile
              SizedBox(height: 80),
              Center(
                child: Card(
                  elevation: 7,
                  color: Colors.white,
                  shadowColor: darkGreen.withOpacity(0.13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Container(
                    width: 320,
                    height: 160,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 34,
                          backgroundColor: lightGreen.withOpacity(0.13),
                          child: Icon(
                            Icons.account_circle,
                            size: 61,
                            color: darkGreen,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          loginController.userSession["username"] ?? "-",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: darkGreen,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ),
              // Jarak lebih kecil
             
              // BODY: Info & Actions
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 5),
                  child: ListView(
                    children: [
                     
                      // Username
                      _InfoTile(
                        icon: Icons.person,
                        title: "Username: ${loginController.userSession["username"] ?? "-"}",
                        color: darkGreen,
                      ),
                      SizedBox(height: 4),
                      // Email
                      _InfoTile(
                        icon: Icons.email,
                        title: "Email: ${loginController.userSession["email"] ?? "-"}",
                        color: darkGreen,
                      ),
                      Divider(color: darkGreen.withOpacity(0.18)),
                      SizedBox(height: 12),
                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 2,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shadowColor: Colors.redAccent.withOpacity(0.18),
                          ),
                          icon: Icon(Icons.logout, color: Colors.white, size: 20),
                          label: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.7,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.13),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.logout, color: Colors.red[400], size: 44),
                                      SizedBox(height: 12),
                                      Text(
                                        "Konfirmasi Logout",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red[400]),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Apakah Anda yakin ingin keluar dari aplikasi?",
                                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 22),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text("Batal", style: TextStyle(color: Colors.grey[600])),
                                          ),
                                          SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red[400],
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            onPressed: () {
                                              UserSession().deleteUser().then((value) {
                                                Get.offAllNamed(RouterGenerator.routeSplash);
                                              });
                                            },
                                            child: Text("Logout", style: TextStyle(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              barrierDismissible: false,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(color: Colors.grey[300]),
                      SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Powered by IDE",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "INTERNASIONAL DATA ELEKTRONIK",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _InfoTile({Key key, this.icon, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(8),
          child: Icon(icon, size: 25, color: color),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            title ?? "-",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({Key key, this.icon, this.title, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Icon(icon, size: 25, color: color),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title ?? "-",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: color.withOpacity(0.22), size: 26)
        ],
      ),
    );
  }
}