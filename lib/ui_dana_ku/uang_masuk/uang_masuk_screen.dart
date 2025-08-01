// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:finance_riza/controller/account_controller.dart';
import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/controller/transaction_controller.dart';
import 'package:finance_riza/model/account.dart';
import 'package:finance_riza/model/transaction.dart';
import 'package:finance_riza/ui_dana_ku/list_data/list_uang_masuk_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:finance_riza/style/styles.dart';

class UangMasukScreen extends StatelessWidget {
  // TextEditingController start_date = TextEditingController();
  // TextEditingController end_date = TextEditingController();

  TextEditingController searchController = TextEditingController();
  ListAllTransactionController listAllTransactionController;
  LoginController loginController;
  AccountController accountController;
  TransactionController transactionController;

  final Color darkGreen = AppStyles.colorPrimary;
  final Color lightGreen = AppStyles.colorAccent;

  @override
  Widget build(BuildContext context) {
    // uangMasukController = Get.find<UangMasukController>();
    // uangMasukController.GetListDataUangMasuk();
    loginController = Get.find<LoginController>();
    listAllTransactionController = Get.find<ListAllTransactionController>();
    listAllTransactionController
        .fetchTransactionsIncome(loginController.userSession['id']);
    accountController = Get.find<AccountController>();
    accountController.fetchAssets();
    accountController.fetchRevenues();
    transactionController = Get.find<TransactionController>();
    return Scaffold(
      backgroundColor: lightGreen.withOpacity(0.08),
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: Text(
          "List Uang Masuk",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showFormUangMasuk(context);
            },
            icon: Icon(Icons.add_circle, color: Colors.white, size: 26),
            tooltip: "Tambah Uang Masuk",
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
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari berdasarkan keterangan ',
                      prefixIcon: Icon(Icons.search, color: darkGreen),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                      // listAllTransactionController.filterTransactions(query);
                      listAllTransactionController.filterByDescription(query);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListUangMasukData(),
            ),
          ),
        ],
      ),
    );
  }

  // form dialog uang masuk
  // di dalam class UangMasukScreen:
  void showFormUangMasuk(BuildContext context) {
    final TextEditingController descController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController tanggalController = TextEditingController();
    final TextEditingController sourceController = TextEditingController();
    String selectedPenerima;
    String selectedPendapatan;

    // Data statis untuk dropdown
    final List<String> daftarPenerima = [
      '1.1001 - Kas',
      '1.1002 - Bank BCA',
      '1.1003 - Bank Mandiri',
    ];
    final List<String> daftarPendapatan = [
      '4.0001 - Pendapatan Jasa',
      '4.0002 - Pendapatan Produk',
      '4.0003 - Pendapatan Lain-lain',
    ];

    // di atas fungsi build/showDialog
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

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
                Text(
                  "Tambah Pemasukan",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 16),

                // Deskripsi
                Text("Deskripsi *",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                TextFormField(
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Contoh: Gaji bulan ini",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                SizedBox(height: 12),

                // Jumlah
                Text("Jumlah *", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final digits =
                          newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
                      if (digits.isEmpty) return newValue.copyWith(text: '');
                      final value = int.parse(digits);
                      final newText = currencyFormatter.format(value);
                      return TextEditingValue(
                        text: newText,
                        selection:
                            TextSelection.collapsed(offset: newText.length),
                      );
                    }),
                  ],
                  decoration: InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                SizedBox(height: 12),

                // Tanggal
                Text("Tanggal *",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                _DateFormField(
                  controller: tanggalController,
                  label: "",
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 12),

                // Rekening Penerima
                Text("Rekening Penerima *",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                DropdownSearch<Account>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  items: accountController.assets,
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  itemAsString: (acc) => "${acc.code} - ${acc.name}",
                  selectedItem: accountController.assets.firstWhere(
                    (a) => a.code == selectedPenerima,
                    orElse: () => null,
                  ),
                  onChanged: (acc) {
                    selectedPenerima = acc?.code;
                  },
                ),
                SizedBox(height: 12),

                // REKENING PENDAPATAN (revenue)
                Text("Rekening Pendapatan *",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                DropdownSearch<Account>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  items: accountController.revenues,
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  itemAsString: (acc) => "${acc.code} - ${acc.name}",
                  selectedItem: accountController.revenues.firstWhere(
                    (a) => a.code == selectedPendapatan,
                    orElse: () => null,
                  ),
                  onChanged: (acc) {
                    selectedPendapatan = acc?.code;
                  },
                ),
                SizedBox(height: 20),

                // Sumber
                Text("Sumber", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                TextFormField(
                  controller: sourceController,
                  decoration: InputDecoration(
                    hintText: "Contoh: PT. ABC",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                SizedBox(height: 12),

                // Buttons
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        if (descController.text.isEmpty ||
                            amountController.text.isEmpty ||
                            tanggalController.text.isEmpty ||
                            selectedPenerima == null ||
                            selectedPendapatan == null) {
                          Get.snackbar(
                              "Validasi", "Harap lengkapi semua field wajib");
                          return;
                        }
                        // Ambil nilai amount (hilangkan format)
                        final digits = amountController.text
                            .replaceAll(RegExp(r'[^0-9]'), '');
                        final amountValue =
                            digits.isEmpty ? 0.0 : double.parse(digits);

                        final trx = Transaction(
                          type: 'income',
                          description: descController.text,
                          amount: amountValue,
                          date: tanggalController.text,
                          source: sourceController.text,
                          debitAccountCode: selectedPenerima,
                          creditAccountCode: selectedPendapatan,
                          // createdBy: ... // isi jika perlu
                        );

                        final success =
                            await transactionController.createIncome(trx);
                        if (success) {
                          Get.back();
                          Get.snackbar(
                            "Berhasil",
                            "Uang masuk: ${trx.description} sejumlah Rp ${NumberFormat('#,##0', 'id_ID').format(trx.amount)} berhasil disimpan.",
                            icon: Icon(Icons.check_circle, color: Colors.white),
                            backgroundColor: Colors.green[700],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            margin: EdgeInsets.all(16),
                            duration: Duration(seconds: 3),
                            borderRadius: 12,
                          );
                          listAllTransactionController.fetchTransactionsIncome(
                              loginController.userSession['id']);
                          // Refresh list jika perlu
                        } else {
                          Get.snackbar(
                            "Gagal",
                            "Uang masuk: ${trx.description} sejumlah Rp ${NumberFormat('#,##0', 'id_ID').format(trx.amount)} gagal disimpan.\n${transactionController.errorMessage.value}",
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
                      child:
                          Text("Simpan", style: TextStyle(color: Colors.white)),
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

// Widget untuk field tanggal pada banner filter tanggal
class _DateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String date) onDatePicked;
  final Color borderColor;

  const _DateField({
    Key key,
    this.controller,
    this.label,
    this.onDatePicked,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      style: TextStyle(fontSize: 13, color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: borderColor.withOpacity(0.11),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white)),
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.white, size: 18),
      ),
      onTap: () async {
        DateTime pickeddate = await showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: borderColor),
                ),
                child: child,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1995),
            lastDate: DateTime(5025));
        if (pickeddate != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(pickeddate);
          if (onDatePicked != null) onDatePicked(controller.text);
        }
      },
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
