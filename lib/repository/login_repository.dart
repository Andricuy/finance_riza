// ignore_for_file: unused_import, non_constant_identifier_names

import 'dart:convert';

import 'package:finance_riza/mixins/server.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  var url = Server.url;

  Future<String> Login(String username, String password) async {
    var link = Uri.parse(url + 'auth/login');
    try {
      var response =
          await http.post(link, body: {"username": username, "password": password});
      print("hasil request login " + username);

      return response.body.toString();
    } catch (e) {
      throw e;
    }
  }
}
