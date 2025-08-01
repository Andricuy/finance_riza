// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, unrelated_type_equality_checks, missing_return, avoid_unnecessary_containers

import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/mixins/utils.dart';
import 'package:finance_riza/ui_dana_ku/widget/item_uang_keluar.dart';
import 'package:finance_riza/ui_dana_ku/widget/item_uang_masuk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListUangKeluarData extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  LoginController loginController = Get.find<LoginController>();
  final ListAllTransactionController controller =
      Get.find<ListAllTransactionController>();

  ListUangKeluarData({Key key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          controller.canLoadMore &&
          !controller.isLoading.value) {
        controller.loadMore(loginController.userSession['id'], 'expense');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pastikan data sudah di-fetch sebelumnya atau bisa fetch di init
    if (controller.transactions.isEmpty && !controller.isLoading.value) {
      controller.fetchTransactionsExpense(loginController.userSession['id']);
    }

    return Obx(() {
      if (controller.isLoading.value && controller.transactions.isEmpty) {
        return Utils().buildLoading();
      } else if (controller.transactions.isEmpty) {
        return Utils().noData();
      } else {
        return ListView.builder(
          controller: _scrollController,
          itemCount:
              controller.transactions.length + (controller.canLoadMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < controller.transactions.length) {
              return ItemUangKeluar(
                  transaction: controller.transactions[index]);
            } else {
              return Utils().buildLoadingFalse();
            }
          },
        );
      }
    });
  }
}
