import 'dart:convert';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/mixins/server.dart';
import 'package:finance_riza/model/list_all_transaction.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ListAllTransactionRepository {
  final String baseUrl = Server.url;
  final LoginController loginController = Get.find<LoginController>();

  /// Fetch paginated transactions for the given username and page
  Future<ListAllTransaction> fetchPaged(String username, int page) async {
    final uri = Uri.parse( baseUrl +'transactions?username=$username&page=$page');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${loginController.userSession['token']}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return ListAllTransaction.fromJson(data);
    } else {
      throw Exception('Failed to fetch transactions, status: \${response.statusCode}');
    }
  }
}