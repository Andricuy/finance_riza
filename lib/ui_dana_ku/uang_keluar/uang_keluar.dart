// ignore_for_file: prefer_const_constructors

import 'package:dropdown_search/dropdown_search.dart';
import 'package:finance_riza/controller/account_controller.dart';
import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/mixins/utils.dart';
import 'package:finance_riza/model/account.dart';
import 'package:finance_riza/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/controller/transaction_controller.dart';
import 'package:finance_riza/model/transaction.dart';
import 'package:finance_riza/ui_dana_ku/list_data/list_uang_keluar_data.dart';
import 'package:intl/intl.dart';



class UangKeluarScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  ListAllTransactionController listAllTransactionController;
  LoginController loginController;
  AccountController accountController;
  TransactionController transactionController;

  final Color darkGreen = AppStyles.colorPrimary;
  final Color lightGreen = AppStyles.colorAccent;

  @override
  Widget build(BuildContext context) {
    loginController = Get.find<LoginController>();
    listAllTransactionController = Get.find<ListAllTransactionController>();
    listAllTransactionController
        .fetchTransactionsExpense(loginController.userSession['id']);
    accountController = Get.find<AccountController>();
    accountController.fetchExpanse();
    accountController.fetchAssets();
    transactionController = Get.find<TransactionController>();
    return Scaffold(
      backgroundColor: lightGreen.withOpacity(0.08),
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: Text(
          "List Uang Keluar",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: showFormUangKeluar(context)
              showFormUangKeluar(context);
            },
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 26,
            ),
            tooltip: "Tambah Uang Keluar",
          )
        ],
      ),
      body: Column(
        children: [
          Material(
            elevation: 2,
            color: darkGreen,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Cari berdasarkan keterangan',
                  prefixIcon: Icon(Icons.search, color: darkGreen),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: lightGreen),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: darkGreen),
                  ),
                ),
                onChanged: (query) {
                  listAllTransactionController.filterByDescription(query);
                },
              ),
            ),
          ),
          SizedBox(height: 14),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListUangKeluarData(),
            ),
          ),
        ],
      ),
    );
  }

  void showFormUangKeluar(BuildContext context) {
    final TextEditingController descController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController tanggalController = TextEditingController();
    final TextEditingController sumberController = TextEditingController();
    final TextEditingController buktiController = TextEditingController();

    String selectedAsset; // rekening sumber pengeluaran
    String selectedExpense; // rekening pengeluaran
    double selectedAssetBalance = 0;
    String saldoWarning = "";

    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: StatefulBuilder(
          builder: (ctx, setState) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.highlight_off_rounded,
                        color: Colors.grey, size: 26),
                  ),
                ),
                Text("Tambah Pengeluaran",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                SizedBox(height: 18),

                // Tanggal
                Text("Tanggal *", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                _DateFormField(
                  controller: tanggalController,
                  label: "",
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 14),

                // Deskripsi
                Text("Deskripsi *", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                TextFormField(
                  controller: descController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "Contoh: Pembayaran listrik kantor",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                SizedBox(height: 14),

                // Rekening Sumber Pengeluaran (Assets)
                Text("Rekening Sumber Pengeluaran *", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                DropdownSearch<Account>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  items: accountController.assets,
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  itemAsString: (acc) => "${acc.code} - ${acc.name}",
                  selectedItem: accountController.assets.firstWhere(
                    (a) => a.code == selectedAsset,
                    orElse: () => null,
                  ),
                  onChanged: (acc) {
                    selectedAsset = acc?.code;
                    if (selectedAsset != null) {
                      accountController.fetchChartAccountCode(selectedAsset);
                    }
                  },
                ),
                SizedBox(height: 6),
                Obx(() {
                  if (accountController.isLoading.value) {
                    return CircularProgressIndicator(strokeWidth: 2);
                  }
                  return Row(
                    children: [
                      Text("Saldo: ${Utils.format.format(accountController.balance.value)}"),
                    ],
                  );
                }),
                SizedBox(height: 14),

                // Jumlah
                Text("Jumlah *", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
                      if (digits.isEmpty) return newValue.copyWith(text: '');
                      final value = int.parse(digits);
                      final newText = currencyFormatter.format(value);
                      return TextEditingValue(
                        text: newText,
                        selection: TextSelection.collapsed(offset: newText.length),
                      );
                    }),
                  ],
                  decoration: InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  onChanged: (val) {
                    final digits = val.replaceAll(RegExp(r'[^0-9]'), '');
                    final inputValue = digits.isEmpty ? 0 : int.parse(digits);
                    final saldo = accountController.balance.value;
                    setState(() {
                      if (inputValue > saldo) {
                        saldoWarning = "Saldo tidak cukup";
                      } else {
                        saldoWarning = "";
                      }
                    });
                  },
                ),
                if (saldoWarning.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      saldoWarning,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 14),

                

                // Rekening Pengeluaran (Expenses)
                Text("Rekening Pengeluaran *", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                DropdownSearch<Account>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  items: accountController.expenses,
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  itemAsString: (acc) => "${acc.code} - ${acc.name}",
                  selectedItem: accountController.expenses.firstWhere(
                    (a) => a.code == selectedExpense,
                    orElse: () => null,
                  ),
                  onChanged: (acc) {
                    selectedExpense = acc?.code;
                  },
                ),
                SizedBox(height: 14),

                // Sumber
                Text("Sumber", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                TextFormField(
                  controller: sumberController,
                  decoration: InputDecoration(
                    hintText: "Contoh: PT. ABC",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                SizedBox(height: 14),

                // No Bukti
                Text("No. Bukti", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                TextFormField(
                  controller: buktiController,
                  decoration: InputDecoration(
                    hintText: "Contoh: MSK001",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Batal"),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppStyles.colorDasar,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        if (descController.text.isEmpty ||
                            amountController.text.isEmpty ||
                            tanggalController.text.isEmpty ||
                            selectedAsset == null ||
                            selectedExpense == null) {
                          Get.snackbar("Validasi", "Harap lengkapi semua field wajib");
                          return;
                        }
                        final amount = int.tryParse(
                          amountController.text.replaceAll(RegExp(r'[^0-9]'), ''),
                        ) ?? 0;
                        final trx = Transaction(
                          type: 'expense',
                          description: descController.text,
                          amount: amount.toDouble(),
                          date: tanggalController.text,
                          source: sumberController.text.isEmpty ? null : sumberController.text,
                          receiptNumber: buktiController.text.isEmpty ? null : buktiController.text,
                          debitAccountCode: selectedExpense, // rekening pengeluaran
                          creditAccountCode: selectedAsset,  // rekening sumber
                          expenseAccountCode: selectedExpense,
                          creditAccountCodeExpense: selectedAsset,
                          fromAccountCode: null,
                          toAccountCode: null,
                          createdBy: loginController.userSession['id'],
                        );
                        final success = await transactionController.createExpense(trx);
                        if (success) {
                          Get.back();
                          Get.snackbar(
                            "Berhasil",
                            "Pengeluaran: ${descController.text} sejumlah Rp ${NumberFormat('#,##0', 'id_ID').format(trx.amount)} berhasil disimpan.",
                            icon: Icon(Icons.check_circle, color: Colors.white),
                            backgroundColor: Colors.green[700],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            margin: EdgeInsets.all(16),
                            duration: Duration(seconds: 3),
                            borderRadius: 12,
                          );
                          listAllTransactionController.fetchTransactionsExpense(
                            loginController.userSession['id'],
                          );
                        } else {
                          Get.snackbar(
                            "Gagal",
                            "Pengeluaran: ${descController.text} sejumlah Rp ${NumberFormat('#,##0', 'id_ID').format(trx.amount)} gagal disimpan.\n${transactionController.errorMessage.value}",
                            icon: Icon(Icons.error, color: Colors.white),
                            backgroundColor: Colors.red[700],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            margin: EdgeInsets.all(16),
                            duration: Duration(seconds: 4),
                            borderRadius: 12,
                          );
                        }
                      },
                      child: Text("Simpan", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk field tanggal pada dialog form
class _DateFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Color borderColor;

  const _DateFormField({
    Key key,
    this.controller,
    this.label,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: "yyyy-MM-dd",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        suffixIcon: Icon(Icons.calendar_today, color: borderColor, size: 20),
      ),
      onTap: () async {
        DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      },
    );
  }
}
