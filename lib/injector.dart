import 'package:finance_riza/controller/account_controller.dart';
import 'package:finance_riza/controller/dashboard_controller.dart';
import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/controller/loading_button_controller.dart';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/controller/menu_controller.dart';
import 'package:finance_riza/controller/save_login_controller.dart';
import 'package:finance_riza/controller/splash_controller.dart';
import 'package:finance_riza/controller/transaction_controller.dart';
import 'package:finance_riza/repository/chart_account_repository.dart';
import 'package:finance_riza/repository/dashboard_repository.dart';
import 'package:finance_riza/repository/list_all_transaction_repository.dart';
import 'package:finance_riza/repository/login_repository.dart';
import 'package:finance_riza/repository/transaction_repository.dart';
import 'package:get/get.dart';

void injectID() {
  Get.put(LoadingButtonController());
  Get.put(LoginRepository());

  Get.put(SaveLoginController());
  Get.put(LoginController());
  Get.put(DashboardRepository());
  Get.put(ListAllTransactionRepository());
  Get.put(ChartAccountRepository());
  Get.put(TransactionRepository());

  Get.put(SplashController());
  Get.put(MenuController());
  Get.put(DashboardController());
  Get.put(ListAllTransactionController());
  Get.put(AccountController());
  Get.put(TransactionController());
}
