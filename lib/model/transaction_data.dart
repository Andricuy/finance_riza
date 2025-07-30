// ignore_for_file: unnecessary_new

import 'dart:convert';

List<TransactionData> transactionDataFromJson(String response) {
  final Map<String, dynamic> jsonData = json.decode(response);
  final Map<String, dynamic> data = jsonData['data'] as Map<String, dynamic>;
  if (data == null) return [];

  final List<dynamic> list = data['recentTransactions'] as List<dynamic>;
  if (list == null) return [];

  return list
      .map((x) => TransactionData.fromJson(x as Map<String, dynamic>))
      .toList();
}

class TransactionData {
  int id;
  String type;
  String description;
  double amount;
  DateTime date;
  String source;
  String receiptNumber;
  String debitAccountCode;
  String creditAccountCode;
  String expenseAccountCode;
  String creditAccountCodeExpense;
  String fromAccountCode;
  String toAccountCode;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  String createdByName;
  String debitAccountName;
  String creditAccountName;
  String expenseAccountName;
  String creditAccountNameExpense;
  String fromAccountName;
  String toAccountName;

  TransactionData(
    this.id,
    this.type,
    this.description,
    this.amount,
    this.date,
    this.source,
    this.receiptNumber,
    this.debitAccountCode,
    this.creditAccountCode,
    this.expenseAccountCode,
    this.creditAccountCodeExpense,
    this.fromAccountCode,
    this.toAccountCode,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.createdByName,
    this.debitAccountName,
    this.creditAccountName,
    this.expenseAccountName,
    this.creditAccountNameExpense,
    this.fromAccountName,
    this.toAccountName,
  );

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      json['id'] as int,
      json['type'] as String,
      json['description'] as String,
      double.parse(json['amount'] as String),
      DateTime.parse(json['date'] as String),
      json['source'] as String,
      json['receipt_number'] as String,
      json['debit_account_code'] as String,
      json['credit_account_code'] as String,
      json['expense_account_code'] != null
          ? json['expense_account_code'] as String
          : '',
      json['credit_account_code_expense'] != null
          ? json['credit_account_code_expense'] as String
          : '',
      json['from_account_code'] != null
          ? json['from_account_code'] as String
          : '',
      json['to_account_code'] != null ? json['to_account_code'] as String : '',
      json['created_by'] as int,
      DateTime.parse(json['created_at'] as String),
      DateTime.parse(json['updated_at'] as String),
      json['created_by_name'] as String,
      json['debit_account_name'] as String,
      json['credit_account_name'] as String,
      json['expense_account_name'] != null
          ? json['expense_account_name'] as String
          : '',
      json['credit_account_name_expense'] != null
          ? json['credit_account_name_expense'] as String
          : '',
      json['from_account_name'] != null
          ? json['from_account_name'] as String
          : '',
      json['to_account_name'] != null ? json['to_account_name'] as String : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'amount': amount.toStringAsFixed(2),
      'date': date.toIso8601String(),
      'source': source,
      'receipt_number': receiptNumber,
      'debit_account_code': debitAccountCode,
      'credit_account_code': creditAccountCode,
      'expense_account_code': expenseAccountCode,
      'credit_account_code_expense': creditAccountCodeExpense,
      'from_account_code': fromAccountCode,
      'to_account_code': toAccountCode,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_by_name': createdByName,
      'debit_account_name': debitAccountName,
      'credit_account_name': creditAccountName,
      'expense_account_name': expenseAccountName,
      'credit_account_name_expense': creditAccountNameExpense,
      'from_account_name': fromAccountName,
      'to_account_name': toAccountName,
    };
  }
}
