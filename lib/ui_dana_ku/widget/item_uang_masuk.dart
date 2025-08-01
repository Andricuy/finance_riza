// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/model/list_all_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:finance_riza/style/styles.dart';

class ItemUangMasuk extends StatelessWidget {
  final TransactionData transaction;
  ItemUangMasuk({@required this.transaction});

  final Color darkGreen = AppStyles.colorPrimary;
  final Color lightGreen = AppStyles.colorAccent;

  ListAllTransactionController listAllTransactionController;

  @override
  Widget build(BuildContext context) {
    listAllTransactionController = Get.find<ListAllTransactionController>();
    final formattedAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(transaction.amount);
    String formattedDate = '';
    if (transaction.createdAt != null && transaction.createdAt.isNotEmpty) {
      try {
        formattedDate = DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(transaction.createdAt));
      } catch (_) {
        formattedDate = transaction.createdAt;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        shadowColor: AppStyles.colorPrimary.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppStyles.colorAccent.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppStyles.colorPrimary, width: 2),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.monetization_on,
                  size: 28,
                  color: AppStyles.colorPrimary,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${transaction.source} - ${transaction.type}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppStyles.colorPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if ((transaction.description ?? '').isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          transaction.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppStyles.colorSidebarText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    Text(
                      formattedAmount,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppStyles.colorPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: AppStyles.colorAccent),
                        SizedBox(width: 4),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppStyles.colorAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await listAllTransactionController
                                .deleteTransaction(transaction.id, 'income');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
