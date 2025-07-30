import 'dart:convert';

class ListAllTransaction {
  String message;
  List<TransactionData> transactions;
  Pagination pagination;

  ListAllTransaction({this.message, this.transactions, this.pagination});

  factory ListAllTransaction.fromJson(Map<String, dynamic> json) {
    var list = json['transactions'] as List;
    List<TransactionData> txList = list.map((e) => TransactionData.fromJson(e)).toList();
    return ListAllTransaction(
      message: json['message'],
      transactions: txList,
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
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
  String fromAccountCode;
  String toAccountCode;
  String createdByName;

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
    this.fromAccountCode,
    this.toAccountCode,
    this.createdByName,
  );

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      json['id'],
      json['type'],
      json['description'],
      double.parse(json['amount']),
      DateTime.parse(json['date']),
      json['source'],
      json['receipt_number'],
      json['debit_account_code'] ?? '',
      json['credit_account_code'] ?? '',
      json['expense_account_code'] ?? '',
      json['from_account_code'] ?? '',
      json['to_account_code'] ?? '',
      json['created_by_name'],
    );
  }
}

class Pagination {
  int currentPage;
  int totalPages;
  int totalRecords;
  bool hasNextPage;
  bool hasPrevPage;

  Pagination(
    this.currentPage,
    this.totalPages,
    this.totalRecords,
    this.hasNextPage,
    this.hasPrevPage,
  );

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      json['currentPage'],
      json['totalPages'],
      json['totalRecords'],
      json['hasNextPage'],
      json['hasPrevPage'],
    );
  }
}