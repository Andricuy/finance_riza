// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:finance_riza/controller/transaction_controller.dart';
import 'package:finance_riza/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

import 'package:finance_riza/controller/account_controller.dart';
import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/model/account.dart';
import 'package:finance_riza/ui_dana_ku/list_data/list_uang_mutasi_data.dart';
import 'package:finance_riza/style/styles.dart';

class UangMutasiScreen extends StatelessWidget {
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
    accountController = Get.find<AccountController>();
    listAllTransactionController
        .fetchTransactionsTransfer(loginController.userSession['id']);
    // Pastikan accountController sudah mem-fetch assets
    accountController.fetchAssets();
    transactionController = Get.find<TransactionController>();

    return Scaffold(
      backgroundColor: lightGreen.withOpacity(0.08),
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: Text(
          "List Mutasi Uang",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
        ),
        actions: [
          IconButton(
            onPressed: () => showFormUangMutasi(context),
            icon: Icon(Icons.swap_horiz, color: Colors.white, size: 26),
            tooltip: "Tambah Transfer",
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
                onChanged: (q) =>
                    listAllTransactionController.filterByDescriptionMutasi(q),
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
              child: ListUangMutasiData(),
            ),
          ),
        ],
      ),
    );
  }

  void showFormUangMutasi(BuildContext context) {
    final amountController = TextEditingController();
    final dateController = TextEditingController();
    final descController = TextEditingController();
    final refController = TextEditingController();
    String selectedSource;
    String selectedTarget;

    final acctCtrl = Get.find<AccountController>();

    // di atas fungsi build/showDialog
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    showDialog(
        context: context,
        builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Obx(() {
                if (acctCtrl.isLoading.value) {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Close button
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Icon(Icons.highlight_off_rounded,
                                color: Colors.grey, size: 26),
                          ),
                        ),
                        SizedBox(height: 4),
                        Center(
                          child: Text(
                            "Tambah Transfer",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Jumlah
                        Text("Jumlah *",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final digits = newValue.text
                                  .replaceAll(RegExp(r'[^0-9]'), '');
                              if (digits.isEmpty)
                                return newValue.copyWith(text: '');
                              final value = int.parse(digits);
                              final newText = currencyFormatter.format(value);
                              return TextEditingValue(
                                text: newText,
                                selection: TextSelection.collapsed(
                                    offset: newText.length),
                              );
                            }),
                          ],
                          decoration: InputDecoration(
                            hintText: "0",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                        ),
                        SizedBox(height: 12),

                        // Tanggal
                        Text("Tanggal *",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        _DateFormField(
                          controller: dateController,
                          label: "",
                          borderColor: Colors.grey,
                        ),
                        SizedBox(height: 12),

                        // Rekening Sumber
                        Text("Rekening Sumber *",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        DropdownSearch<Account>(
                          mode: Mode.MENU,
                          showSearchBox: true,
                          items: acctCtrl.assets,
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                          itemAsString: (a) => "${a.code} - ${a.name}",
                          selectedItem: acctCtrl.assets.firstWhere(
                            (a) => a.code == selectedSource,
                            orElse: () => null,
                          ),
                          onChanged: (a) => selectedSource = a?.code,
                        ),
                        SizedBox(height: 12),

                        // Rekening Tujuan
                        Text("Rekening Tujuan *",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        DropdownSearch<Account>(
                          mode: Mode.MENU,
                          showSearchBox: true,
                          items: acctCtrl.assets,
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                          itemAsString: (a) => "${a.code} - ${a.name}",
                          selectedItem: acctCtrl.assets.firstWhere(
                            (a) => a.code == selectedTarget,
                            orElse: () => null,
                          ),
                          onChanged: (a) => selectedTarget = a?.code,
                        ),
                        SizedBox(height: 12),

                        // Deskripsi
                        Text("Deskripsi *",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextFormField(
                          controller: descController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "Contoh: Transfer ke tabungan",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                        ),
                        SizedBox(height: 12),

                        // Nomor Referensi
                        Text("Nomor Referensi",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextFormField(
                          controller: refController,
                          decoration: InputDecoration(
                            hintText: "Contoh: TRX123456789",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                        ),
                        SizedBox(height: 20),

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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () async {
                                if (amountController.text.isEmpty ||
                                    dateController.text.isEmpty ||
                                    selectedSource == null ||
                                    selectedTarget == null ||
                                    descController.text.isEmpty) {
                                  Get.snackbar("Validasi",
                                      "Harap lengkapi semua field wajib");
                                  return;
                                }
                                // Ambil nominal tanpa format
                                final amount = int.tryParse(
                                      amountController.text
                                          .replaceAll(RegExp(r'[^0-9]'), ''),
                                    ) ??
                                    0;
                                // Cari nama bank dari kode
                                String sourceName = acctCtrl.assets
                                        .firstWhere(
                                          (a) => a.code == selectedSource,
                                          orElse: () => null,
                                        )
                                        ?.name ??
                                    selectedSource;
                                String targetName = acctCtrl.assets
                                        .firstWhere(
                                          (a) => a.code == selectedTarget,
                                          orElse: () => null,
                                        )
                                        ?.name ??
                                    selectedTarget;
                                // Buat objek Transaction
                                final trx = Transaction(
                                  amount: amount.toDouble(),
                                  date: dateController.text,
                                  description: descController.text,
                                  receiptNumber: refController.text,
                                  debitAccountCode:
                                      selectedSource, // rekening sumber
                                  creditAccountCode:
                                      selectedTarget, // rekening tujuan
                                  fromAccountCode:
                                      selectedSource, // rekening sumber
                                  toAccountCode:
                                      selectedTarget, // rekening tujuan
                                  type: 'transfer',
                                  createdBy: loginController.userSession['id'],
                                );
                                // Simpan mutasi via controller
                                final success = await transactionController
                                    .createMutasi(trx);
                                if (success) {
                                  Get.back();
                                  Get.snackbar(
                                    "Berhasil",
                                    "Mutasi dari ${sourceName} ke ${targetName} sejumlah Rp ${NumberFormat('#,##0', 'id_ID').format(trx.amount)} berhasil disimpan.",
                                    icon: Icon(Icons.check_circle,
                                        color: Colors.white),
                                    backgroundColor: Colors.green[700],
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.TOP,
                                    margin: EdgeInsets.all(16),
                                    duration: Duration(seconds: 3),
                                    borderRadius: 12,
                                  );
                                  listAllTransactionController
                                      .fetchTransactionsTransfer(
                                          loginController.userSession['id']);
                                } else {
                                  Get.snackbar(
                                    "Gagal",
                                    "Mutasi dari ${sourceName} ke ${targetName} sejumlah Rp ${NumberFormat('#,##0', 'id_ID').format(trx.amount)} gagal disimpan.\n${transactionController.errorMessage.value}",
                                    icon:
                                        Icon(Icons.error, color: Colors.white),
                                    backgroundColor: Colors.red[700],
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.TOP,
                                    margin: EdgeInsets.all(16),
                                    duration: Duration(seconds: 4),
                                    borderRadius: 12,
                                  );
                                }
                              },
                              child: Text("Simpan",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        )
                      ],
                    ));
              }),
            ));
  }
}

// _DateFormField sama seperti di UangMasukScreen
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
        final dt = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (dt != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(dt);
        }
      },
    );
  }
}
