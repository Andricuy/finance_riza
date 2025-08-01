import 'dart:convert';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/model/account.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../mixins/server.dart';

class ChartAccountRepository {
  final String baseUrl = Server.url;
    LoginController loginController = Get.find<LoginController>();

  Future<List<Account>> fetchByCategory(String category) async {
    final uri = Uri.parse(baseUrl + 'accounts');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginController.userSession["token"]}',
      },
    );
    if (response.statusCode == 200) {
      return accountFromJson(response.body)
          .where((acc) => acc.category == category)
          .toList();
    } else {
      throw Exception('Failed to load accounts');
    }
  }

  Future<String> fetchChartAcountCode(String code) async {
    var link = Uri.parse(baseUrl + "transactions/accounts/$code/balance");
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
