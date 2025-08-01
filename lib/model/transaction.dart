class Transaction {
  int id;
  String type;
  String description;
  double amount;
  String date;
  String source;
  String receiptNumber;
  String debitAccountCode;
  String creditAccountCode;
  String fromAccountCode;
  String toAccountCode;
  int createdBy;
  String expenseAccountCode;
  String creditAccountCodeExpense;

  Transaction({
    this.id,
    this.type,
    this.description,
    this.amount,
    this.date,
    this.source,
    this.receiptNumber,
    this.debitAccountCode,
    this.creditAccountCode,
    this.fromAccountCode,
    this.toAccountCode,
    this.createdBy,
    this.expenseAccountCode,
    this.creditAccountCodeExpense,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        type: json['type'],
        description: json['description'],
        amount: (json['amount'] is int)
            ? (json['amount'] as int).toDouble()
            : (json['amount'] ?? 0.0),
        date: json['date'],
        source: json['source'],
        receiptNumber: json['receipt_number'],
        debitAccountCode: json['debit_account_code'],
        creditAccountCode: json['credit_account_code'],
        fromAccountCode: json['from_account_code'],
        toAccountCode: json['to_account_code'],
        createdBy: json['created_by'],
        expenseAccountCode: json['expense_account_code'],
        creditAccountCodeExpense: json['credit_account_code_expense'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'description': description,
        'amount': amount,
        'date': date,
        'source': source,
        'receipt_number': receiptNumber,
        'debit_account_code': debitAccountCode,
        'credit_account_code': creditAccountCode,
        'from_account_code': fromAccountCode,
        'to_account_code': toAccountCode,
        'created_by': createdBy,
        'expense_account_code': expenseAccountCode,
        'credit_account_code_expense': creditAccountCodeExpense,
      };
}