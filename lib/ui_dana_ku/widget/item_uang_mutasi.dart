// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:finance_riza/model/list_all_transaction.dart';
import 'package:finance_riza/style/styles.dart';

class ItemUangMutasi extends StatelessWidget {
  final TransactionData transaction;
  ItemUangMutasi({this.transaction});

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
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        color: Colors.white,
        shadowColor: AppStyles.colorPrimary.withOpacity(0.18),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(Icons.highlight_off_rounded, color: Colors.grey, size: 26),
                        ),
                      ),
                      Text("Detail Transfer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppStyles.colorPrimary)),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.sync_alt_rounded, color: AppStyles.colorAccent, size: 28),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "${transaction.fromAccountName} → ${transaction.toAccountName}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppStyles.colorPrimary),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 24, thickness: 1, color: AppStyles.colorAccent.withOpacity(0.3)),
                      Text("Nominal", style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text(
                        formattedAmount,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppStyles.colorPrimary),
                      ),
                      SizedBox(height: 12),
                      Text("Tanggal", style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 14, color: AppStyles.colorSidebarText),
                      ),
                      SizedBox(height: 12),
                      if ((transaction.description ?? '').isNotEmpty) ...[
                        Text("Keterangan", style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text(transaction.description, style: TextStyle(fontSize: 14, color: AppStyles.colorSidebarText)),
                        SizedBox(height: 12),
                      ],
                      if ((transaction.receiptNumber ?? '').isNotEmpty) ...[
                        Text("No. Referensi", style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text(transaction.receiptNumber, style: TextStyle(fontSize: 14, color: AppStyles.colorSidebarText)),
                        SizedBox(height: 12),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Tutup", style: TextStyle(color: AppStyles.colorPrimary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppStyles.colorAccent.withOpacity(0.16),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppStyles.colorPrimary, width: 2.3),
                    boxShadow: [
                      BoxShadow(
                        color: AppStyles.colorPrimary.withOpacity(0.08),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(13),
                  child: Icon(
                    Icons.sync_alt_rounded,
                    size: 28,
                    color: AppStyles.colorPrimary,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${transaction.fromAccountName} → ${transaction.toAccountName}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppStyles.colorPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if ((transaction.description ?? '').isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.5),
                          child: Text(
                            transaction.description,
                            style: TextStyle(
                                fontSize: 13, color: AppStyles.colorSidebarText),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      Text(
                        formattedAmount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppStyles.colorPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded,
                              size: 13, color: AppStyles.colorAccent),
                          SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppStyles.colorAccent,
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () async {
                              await listAllTransactionController
                                  .deleteTransaction(
                                      transaction.id, 'transfer');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppStyles.colorPrimary.withOpacity(0.22)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
