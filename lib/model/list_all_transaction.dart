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
  String creditAccountCodeExpense;
  String fromAccountCode;
  String toAccountCode;
  int createdBy;
  String createdByName;
  String debitAccountName;
  String creditAccountName;
  String expenseAccountName;
  String creditAccountNameExpense;
  String fromAccountName;
  String toAccountName;
  String createdAt;
  String updatedAt;

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
    this.createdByName,
    this.debitAccountName,
    this.creditAccountName,
    this.expenseAccountName,
    this.creditAccountNameExpense,
    this.fromAccountName,
    this.toAccountName,
    this.createdAt,
    this.updatedAt,
  );

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      json['id'],
      json['type'],
      json['description'],
      double.tryParse(json['amount'].toString()) ?? 0.0,
      DateTime.parse(json['date']),
      json['source'],
      json['receipt_number'],
      json['debit_account_code'],
      json['credit_account_code'],
      json['expense_account_code'],
      json['credit_account_code_expense'],
      json['from_account_code'],
      json['to_account_code'],
      json['created_by'],
      json['created_by_name'],
      json['debit_account_name'],
      json['credit_account_name'],
      json['expense_account_name'],
      json['credit_account_name_expense'],
      json['from_account_name'],
      json['to_account_name'],
      json['created_at'],
      json['updated_at'],
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