// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class UangMasukScreen extends StatelessWidget {
  TextEditingController start_date = TextEditingController();
  TextEditingController end_date = TextEditingController();
  ListAllTransactionController listAllTransactionController;
  LoginController loginController;

  final Color darkGreen = Color(0xFF4C7148);
  final Color lightGreen = Color(0xFFA3C78D);

  @override
  Widget build(BuildContext context) {
    // uangMasukController = Get.find<UangMasukController>();
    // uangMasukController.GetListDataUangMasuk();
    loginController = Get.find<LoginController>();
    listAllTransactionController = Get.find<ListAllTransactionController>();
    listAllTransactionController.fetchTransactionsIncome(loginController.userSession['username']);
    
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
                  Row(
                    children: [
                      Expanded(
                        child: _DateField(
                          controller: start_date,
                          label: "Start date",
                          onDatePicked: (date) {
                            start_date.text = date;
                          },
                          borderColor: lightGreen,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _DateField(
                          controller: end_date,
                          label: "End date",
                          onDatePicked: (date) {
                            end_date.text = date;
                          },
                          borderColor: lightGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.symmetric(vertical: 13),
                        elevation: 1,
                      ),
                      icon: Icon(Icons.search, color: darkGreen),
                      label: Text(
                        "Cari Data",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: darkGreen),
                      ),
                      onPressed: () {
                        if (start_date.text.isEmpty || end_date.text.isEmpty) {
                          Get.snackbar(
                              "Validasi", "Tanggal harus diisi dengan benar");
                        } else {
                          // uangMasukController.getListDataUangMasukDate(
                          //     start_date.text, end_date.text);
                        }
                      },
                    ),
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
              // child: uangMasukController.list.isEmpty
              //     ? ListUangMasuk()
              //     : ListUangMasukDate(),
            ),
          ),
        ],
      ),
    );
  }

  // form dialog uang masuk
  void showFormUangMasuk(BuildContext context) {
    TextEditingController tanggal = TextEditingController();
    var tipePayment = "0".obs;
    var nilaiAdmin = 0.0.obs;
    TextEditingController jumlahUangMasuk = TextEditingController();
    TextEditingController remarkText = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Icon(Icons.highlight_off_rounded,
                          color: Colors.redAccent, size: 26),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text("Form Uang Masuk",
                      style: TextStyle(
                          fontSize: 16,
                          color: darkGreen,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  _DateFormField(
                    controller: tanggal,
                    label: "Tanggal",
                    borderColor: darkGreen,
                  ),
                  SizedBox(height: 12),
                  // BANK Dropdown
                  // Theme(
                  //   data: ThemeData(textTheme: TextTheme()),
                  //   child: DropdownSearch<String>(
                  //     mode: Mode.MENU,
                  //     showSearchBox: true,
                  //     showSelectedItems: true,
                  //     popupBackgroundColor: Colors.white,
                  //     dropdownSearchDecoration: InputDecoration(
                  //       hintText: "Bank",
                  //       labelText: "Bank",
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //         borderSide: BorderSide(color: darkGreen),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //         borderSide: BorderSide(color: lightGreen),
                  //       ),
                  //       labelStyle: TextStyle(color: darkGreen),
                  //       suffixStyle: TextStyle(color: darkGreen),
                  //       contentPadding:
                  //           EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  //     ),
                  //     onChanged: (value) {
                  //       final parts = value.split(' - ');
                  //       final bank_name = parts[0];
                  //       final biaya_admin = parts[1];
                  //       nilaiAdmin.value = double.tryParse(biaya_admin);
                  //       tipePayment.value = bank_name;
                  //     },
                  //     onFind: (text) async {
                  //       var url = Server.url;
                  //       var link = Uri.parse(url +
                  //           "getBank?unit=${loginController.userSession['unit']}");
                  //       try {
                  //         var response = await http.get(link);
                  //         List allMeja = (json.decode(response.body)
                  //             as Map<String, dynamic>)["data"];
                  //         List<String> allMejas = [];
                  //         allMeja.forEach((element) {
                  //           String combinedValue =
                  //               "${element["bank_name"]} - ${element["biaya_admin"]}";
                  //           allMejas.add(combinedValue);
                  //         });
                  //         return allMejas;
                  //       } catch (e) {
                  //         return e;
                  //       }
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: 12),
                  // TextFormField(
                  //   controller: jumlahUangMasuk,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     labelText: "Jumlah Masuk",
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12)),
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  //   ),
                  //   onChanged: (value) {
                  //     String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                  //     if (newValue.isEmpty) {
                  //       jumlahUangMasuk.text = '';
                  //       return;
                  //     }
                  //     final formatter = NumberFormat.currency(
                  //         locale: 'id_ID', symbol: '', decimalDigits: 0);
                  //     String formatted = formatter.format(int.parse(newValue));
                  //     jumlahUangMasuk.value = TextEditingValue(
                  //       text: formatted,
                  //       selection:
                  //           TextSelection.collapsed(offset: formatted.length),
                  //     );
                  //   },
                  // ),
                  // SizedBox(height: 12),
                  // TextFormField(
                  //   controller: remarkText,
                  //   decoration: InputDecoration(
                  //     labelText: "Keterangan",
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12)),
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  //   ),
                  // ),
                  // SizedBox(height: 18),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Obx(() {
                  //     final loading = uangMasukController.isLoading.value;
                  //     return ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: darkGreen,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(14)),
                  //         padding: EdgeInsets.symmetric(vertical: 13),
                  //         elevation: 1,
                  //       ),
                  //       // tombol disable saat loading
                  //       onPressed: loading
                  //           ? null
                  //           : () async {
                  //               if (tanggal.text.isEmpty ||
                  //                   tipePayment.value == "0" ||
                  //                   jumlahUangMasuk.text.isEmpty) {
                  //                 Get.snackbar("Validasi",
                  //                     "Harap lengkapi semua field wajib");
                  //                 return;
                  //               }
                  //               // siapkan data
                  //               final data = SaveUangMasuk(
                  //                 unit: loginController.userSession['unit'],
                  //                 typePayment: tipePayment.value,
                  //                 remark: remarkText.text,
                  //                 totalReceipt: int.tryParse(jumlahUangMasuk
                  //                         .text
                  //                         .replaceAll(RegExp(r'[^0-9]'), '')) ??
                  //                     0,
                  //                 tglUangMasuk: tanggal.text,
                  //                 createdBy:
                  //                     loginController.userSession['nama'],
                  //               );
                  //               // simpan
                  //               await uangMasukController.saveUangMasuk(data);
                  //               if (uangMasukController.isSuccess.value) {
                  //                 Get.back();
                  //                 uangMasukController.GetListDataUangMasuk();
                  //                 Get.snackbar(
                  //                   "Sukses",
                  //                   "Data berhasil disimpan",
                  //                   icon: Icon(Icons.check_circle,
                  //                       color: Colors.white, size: 30),
                  //                   shouldIconPulse: false,
                  //                   barBlur: 8,
                  //                   isDismissible: true,
                  //                   snackPosition: SnackPosition.TOP,
                  //                   margin: EdgeInsets.all(18),
                  //                   borderRadius: 18,
                  //                   backgroundColor:
                  //                       Color(0xFF4C7148).withOpacity(0.93),
                  //                   colorText: Colors.white,
                  //                   leftBarIndicatorColor: Color(0xFFA3C78D),
                  //                   boxShadows: [
                  //                     BoxShadow(
                  //                       color: Colors.black26,
                  //                       blurRadius: 8,
                  //                       offset: Offset(0, 3),
                  //                     )
                  //                   ],
                  //                   duration: Duration(seconds: 3),
                  //                 );
                  //               } else {
                  //                 Get.snackbar("Gagal",
                  //                     uangMasukController.errorMessage.value);
                  //               }
                  //             },
                  //       child: loading
                  //           // tampilkan spinner saat loading
                  //           ? SizedBox(
                  //               height: 20,
                  //               width: 20,
                  //               child: CircularProgressIndicator(
                  //                 strokeWidth: 2,
                  //                 valueColor:
                  //                     AlwaysStoppedAnimation(Colors.white),
                  //               ),
                  //             )
                  //           : Text(
                  //               "Submit",
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.white),
                  //             ),
                  //     );
                  //   }),
                  // )
                ],
              ),
            ),
          ),
        );
      },
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
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        suffixIcon: Icon(Icons.calendar_today, color: borderColor, size: 18),
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
