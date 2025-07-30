import 'dart:convert';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/mixins/server.dart';
import 'package:finance_riza/model/transaction_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  LoginController loginController = Get.find<LoginController>();
  var url = Server.url;



  Future<String> fetchRecentTransactions(String username) async {
    var link = Uri.parse(url + "dashboard/stats?username=$username");
    try {
      final response = await http.get(link, headers: {
        'Authorization': 'Bearer ${loginController.userSession["token"]}',
        'Content-Type': 'application/json',
      });
      print(response.body);
      return response.body;
    } catch (e) {
      throw e;
    }
  }
}
