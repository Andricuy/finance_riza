// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:finance_riza/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CardDashboard extends StatelessWidget {
  final TransactionData transactionData;

  CardDashboard({this.transactionData});

  @override
  Widget build(BuildContext context) {
    // Tentukan ikon dan warna berdasarkan type
    IconData icon;
    Color iconColor;
    Color amountColor;
    String amountPrefix;

    switch (transactionData.type) {
      case 'income':
        icon = FontAwesomeIcons.arrowDown;
        iconColor = Colors.green;
        amountColor = Colors.green;
        amountPrefix = '+';
        break;
      case 'transfer':
        icon = FontAwesomeIcons.arrowsRotate;
        iconColor = Colors.blueGrey;
        amountColor = Colors.green;
        amountPrefix = '+';
        break;
      default: // 'expense'
        icon = FontAwesomeIcons.arrowUp;
        iconColor = Colors.red;
        amountColor = Colors.red;
        amountPrefix = '-';
    }

    // Format date dan amount
    final dateStr = DateFormat('dd MMM yyyy').format(transactionData.date);
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final amountStr = amountPrefix + currency.format(transactionData.amount);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: FaIcon(icon, color: iconColor),
        ),
        title: Text(
          transactionData.description,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('$dateStr · ${currency.format(transactionData.amount)}'),
        trailing: Text(
          amountStr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: amountColor,
          ),
        ),
      ),
    );
  }
}
