// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, unrelated_type_equality_checks, missing_return, avoid_unnecessary_containers

import 'package:finance_riza/controller/dashboard_controller.dart';
import 'package:finance_riza/mixins/utils.dart';
import 'package:finance_riza/ui_dana_ku/widget/card_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTransactionData extends StatelessWidget {
  DashboardController dashboardController;
  @override
  Widget build(BuildContext context) {
    dashboardController = Get.find<DashboardController>();
    return Container(
      child: Obx(
        () {
          if (dashboardController.isLoading == true) {
            return Utils().buildLoading();
          } else {
            if (dashboardController.transactions.isEmpty) {
              return Utils().noData();
            } else if (dashboardController.transactions.isNotEmpty) {
              return ListView.builder(
                  itemCount: dashboardController.transactions.length + 1,
                  itemBuilder: (ctx, index) {
                    if (index < dashboardController.transactions.length) {
                      return CardDashboard(
                        transactionData:  dashboardController.transactions[index],
                      );
                    } else {
                      return Utils().buildLoadingFalse();
                    }
                  });
            }
          }
        },
      ),
    );
  }
}
