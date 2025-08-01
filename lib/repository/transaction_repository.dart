import 'dart:convert';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/mixins/server.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:finance_riza/model/transaction.dart';

class TransactionRepository {
  Future<Map<String, dynamic>> createMutasi(Transaction trx) async {
    var link = Uri.parse(url + 'transactions/mutasi');
    final response = await http.post(
      link,
      headers: {
        'Authorization': 'Bearer ${loginController.userSession["token"]}',
        'Content-Type': 'application/json',
      },
      body: json.encode(trx.toJson()),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(
          json.decode(response.body)['error'] ?? 'Gagal input mutasi');
    }
  }

  Future<Map<String, dynamic>> createExpense(Transaction trx) async {
    var link = Uri.parse(url + 'transactions/expense');
    final response = await http.post(
      link,
      headers: {
        'Authorization': 'Bearer ${loginController.userSession["token"]}',
        'Content-Type': 'application/json',
      },
      body: json.encode(trx.toJson()),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(
          json.decode(response.body)['error'] ?? 'Gagal input pengeluaran');
    }
  }
  LoginController loginController = Get.find<LoginController>();
  var url = Server.url;

  Future<Map<String, dynamic>> createTransaksi(Transaction trx) async {
    var link = Uri.parse(url + 'transactions');
    final response = await http.post(
      link,
      headers: {
        'Authorization': 'Bearer ${loginController.userSession["token"]}',
        'Content-Type': 'application/json',
      },
      body: json.encode(trx.toJson()),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(
          json.decode(response.body)['error'] ?? 'Gagal input transaksi');
    }
  }

  
}
