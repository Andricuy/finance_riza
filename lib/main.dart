// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:finance_riza/injector.dart';
import 'package:finance_riza/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;


void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  // Menginisialisasi GetStorage
  await GetStorage.init();
  var appDcumentDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDcumentDir.path);
  injectID();
  await initializeDateFormatting('id_ID', null);

  // Mengunci orientasi ke mode potret
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterGenerator.generateRoute,
      initialRoute: RouterGenerator.routeSplash,
    );
  }
}
