// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:convert';


import 'package:finance_riza/model/list_all_transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class ItemUangMasuk extends StatelessWidget {
  final TransactionData transaction;
  ItemUangMasuk({@required this.transaction});

  final Color darkGreen = const Color(0xFF4C7148);
  final Color lightGreen = const Color(0xFFA3C78D);

  @override
  Widget build(BuildContext context) {
    final formattedAmount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(transaction.amount);
    final formattedDate = DateFormat('yyyy-MM-dd').format(transaction.date);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        shadowColor: darkGreen.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: lightGreen.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: darkGreen, width: 2),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.monetization_on,
                  size: 28,
                  color: darkGreen,
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
                        color: darkGreen,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if ((transaction.description ?? '').isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          transaction.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
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
                        color: darkGreen,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12,
                          color: lightGreen,
                        ),
                        SizedBox(width: 4),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: lightGreen,
                            fontWeight: FontWeight.w600,
                          ),
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
