// ignore_for_file: missing_return

import 'package:finance_riza/ui_dana_ku/login/login_screen.dart';
import 'package:finance_riza/ui_dana_ku/menu_dana_ku/menu_dana_ku_screen.dart';
import 'package:finance_riza/ui_dana_ku/splash/splash_screen.dart';
import 'package:finance_riza/ui_dana_ku/uang_keluar/uang_keluar.dart';
import 'package:finance_riza/ui_dana_ku/uang_masuk/uang_masuk_screen.dart';
import 'package:finance_riza/ui_dana_ku/uang_mutasi/uang_mutasi.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static const routeLogin = "/login";
  static const routeMenuDanaKu = "/menu_dana_ku";
  static const routeSplash = "/splash";
  static const routeUangMasuk = "/uang_masuk";
  static const routeUangMutasiDanaKu = "/uang_mutasi_dana_ku";
  static const routeUangKeluarDanaKu = "/uang_keluar";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic> params = settings.arguments as Map<String, dynamic>;
    if (settings.name == routeMenuDanaKu) {
      return MaterialPageRoute(builder: (_) => MenuDanaKuScreen());
    } else if (settings.name == routeSplash) {
      return MaterialPageRoute(builder: (_) => SplashScreen());
    } else if (settings.name == routeLogin) {
      return MaterialPageRoute(builder: (_) => LoginScreen());
    } else if (settings.name == routeUangMasuk) {
      return MaterialPageRoute(builder: (_) => UangMasukScreen());
    }else if (settings.name == routeUangMutasiDanaKu) {
      return MaterialPageRoute(builder: (_) => UangMutasiScreen());
    }else if (settings.name == routeUangKeluarDanaKu) {
      return MaterialPageRoute(builder: (_) => UangKeluarScreen());
    }
  }
}
