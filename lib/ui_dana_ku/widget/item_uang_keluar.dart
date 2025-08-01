// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:finance_riza/model/list_all_transaction.dart';
import 'package:finance_riza/style/styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItemUangKeluar extends StatelessWidget {
  final TransactionData transaction;
  ItemUangKeluar({@required this.transaction});

  final Color darkGreen = AppStyles.colorPrimary;
  final Color redAccent = Colors.redAccent;
  final Color lightGreen = AppStyles.colorAccent;

   ListAllTransactionController listAllTransactionController;

  @override
  Widget build(BuildContext context) {
    listAllTransactionController = Get.find<ListAllTransactionController>();
    // Format jumlah dan tanggal
    final formattedAmount = NumberFormat.currency(
      locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0,
    ).format(transaction.amount);
    String formattedDate = '';
    if (transaction.createdAt != null && transaction.createdAt.isNotEmpty) {
      try {
        formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(transaction.createdAt));
      } catch (_) {
        formattedDate = transaction.createdAt;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        shadowColor: AppStyles.colorPrimary.withOpacity(0.13),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // TODO: panggil editFormUangKeluar jika perlu
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon keluar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.redAccent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.06), blurRadius: 7, offset: Offset(0,2)
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(13),
                  child: Icon(
                    Icons.money_off, size: 28, color: Colors.redAccent,
                  ),
                ),
                SizedBox(width: 14),
                // Info utama
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Deskripsi atau source
                      Text(
                        transaction.description?.isNotEmpty == true
                          ? transaction.description
                          : transaction.source,
                        style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold, color: AppStyles.colorPrimary,
                        ),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                      // Nominal keluar
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: Text(
                          '- $formattedAmount',
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800, color: Colors.redAccent,
                          ),
                        ),
                      ),
                      // Tanggal dan delete
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, size: 13, color: AppStyles.colorAccent),
                          SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 12, color: AppStyles.colorAccent, fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () async {
                              await listAllTransactionController
                                  .deleteTransaction(transaction.id, 'expense');
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
      ),
    );
  }
}