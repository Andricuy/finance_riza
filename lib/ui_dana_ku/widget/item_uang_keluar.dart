// // ignore_for_file: prefer_const_constructors

// import 'dart:convert';

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:villatte/controller/dana_ku/uang_keluar_controller.dart';
// import 'package:villatte/controller/login_controller.dart';
// import 'package:villatte/mixins/server.dart';
// import 'package:villatte/mixins/utils.dart';
// import 'package:villatte/model/edit_uang_keluar.dart';
// import 'package:villatte/model/list_uang_keluar.dart';
// import 'package:villatte/style/styles.dart';
// import 'package:http/http.dart' as http;

// class ItemUangKeluar extends StatelessWidget {
//   final ListUangKeluar listUangKeluar;
//   ItemUangKeluar({this.listUangKeluar});

//   LoginController loginController;
//   UangKeluarController uangKeluarController;

//   final Color darkGreen = const Color(0xFF4C7148);
//   final Color lightGreen = const Color(0xFFA3C78D);

//   @override
//   Widget build(BuildContext context) {
//     loginController = Get.find<LoginController>();
//     uangKeluarController = Get.find<UangKeluarController>();

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
//       child: Card(
//         elevation: 5,
//         color: Colors.white,
//         shadowColor: darkGreen.withOpacity(0.13),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(22),
//         ),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(22),
//           onTap: () => editFormUangKeluar(context),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Icon uang keluar
//                 Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent.withOpacity(0.12),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.redAccent, width: 2),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.redAccent.withOpacity(0.06),
//                             blurRadius: 7,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       padding: EdgeInsets.all(13),
//                       child: Icon(
//                         Icons.monetization_on,
//                         size: 28,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                     if (listUangKeluar.status != "0")
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.green,
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white, width: 1.5),
//                           ),
//                           padding: EdgeInsets.all(3),
//                           child: Icon(
//                             Icons.check,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 SizedBox(width: 14),
//                 // Info utama
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Judul + keterangan
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "(${listUangKeluar.keterangan}) ${listUangKeluar.detailPengeluaran}",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: darkGreen,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Nominal
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 2.5),
//                         child: Text(
//                           "Rp -${Utils.format.format(listUangKeluar.biaya)}",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.redAccent,
//                           ),
//                         ),
//                       ),
//                       // Tanggal
//                       Row(
//                         children: [
//                           Icon(Icons.calendar_today_rounded,
//                               size: 13, color: lightGreen),
//                           SizedBox(width: 4),
//                           Text(
//                             "${listUangKeluar.createdDate}",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: lightGreen,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Arrow edit
//                 Icon(Icons.edit_note,
//                     color: darkGreen.withOpacity(0.22), size: 25),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void editFormUangKeluar(BuildContext context) {
//     TextEditingController tanggalSblm =
//         TextEditingController(text: listUangKeluar.createdDate);
//     TextEditingController tanggal = TextEditingController();
//     TextEditingController jumlahUangKeluar = TextEditingController(
//       text: Utils.format.format(listUangKeluar.biaya),
//     );
//     TextEditingController remarkText = TextEditingController(
//       text: listUangKeluar.detailPengeluaran,
//     );

//     var tipePayment = listUangKeluar.keterangan.obs;
//     var typeMutasiKeluar = listUangKeluar.typeBiaya.obs;

//     showDialog(
//       context: context,
//       builder: (_) {
//         return Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//           backgroundColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header dialog
//                   Row(
//                     children: [
//                       Icon(Icons.edit, color: darkGreen, size: 20),
//                       SizedBox(width: 7),
//                       Expanded(
//                         child: Text(
//                           "Edit Uang Keluar ${listUangKeluar.transCode}",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: darkGreen),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => Get.back(),
//                         child: Icon(Icons.highlight_off_rounded,
//                             color: Colors.redAccent),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // Tanggal sebelumnya (readonly)
//                   _InfoRow(
//                     label: "Tanggal Sebelumnya",
//                     value: listUangKeluar.createdDate,
//                     icon: Icons.calendar_today_rounded,
//                   ),
//                   SizedBox(height: 10),
//                   // Field tanggal baru
//                   TextFormField(
//                     controller: tanggal,
//                     readOnly: true,
//                     style: TextStyle(color: darkGreen),
//                     decoration: InputDecoration(
//                       labelText: "Tanggal Ubah",
//                       labelStyle: TextStyle(color: darkGreen),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: darkGreen),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: darkGreen),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: lightGreen),
//                       ),
//                       suffixIcon:
//                           Icon(Icons.date_range, color: lightGreen, size: 19),
//                     ),
//                     onTap: () async {
//                       DateTime picked = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (picked != null) {
//                         tanggal.text = DateFormat('yyyy-MM-dd').format(picked);
//                       }
//                     },
//                   ),
//                   SizedBox(height: 13),
//                   // BANK
//                   Text("Bank",
//                       style: TextStyle(
//                           color: darkGreen, fontWeight: FontWeight.w600)),
//                   SizedBox(height: 5),
//                   Theme(
//                     data: ThemeData(textTheme: TextTheme()),
//                     child: DropdownSearch<String>(
//                       mode: Mode.MENU,
//                       showSearchBox: true,
//                       showSelectedItems: true,
//                       popupBackgroundColor: lightGreen.withOpacity(0.97),
//                       dropdownSearchDecoration: InputDecoration(
//                         hintText: "Pilih Bank",
//                         labelStyle: TextStyle(color: darkGreen),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: darkGreen),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: darkGreen),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: lightGreen),
//                         ),
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 13),
//                       ),
//                       selectedItem: tipePayment.value,
//                       onChanged: (value) {
//                         final parts = value.split(' - ');
//                         final bank_name = parts[0];
//                         tipePayment.value = bank_name;
//                       },
//                       onFind: (text) async {
//                         var url = Server.url;
//                         var link = Uri.parse(url +
//                             "getBank?unit=${loginController.userSession['unit']}");
//                         try {
//                           var response = await http.get(link);
//                           List allMeja = (json.decode(response.body)
//                               as Map<String, dynamic>)["data"];
//                           List<String> allMejas = [];
//                           allMeja.forEach((element) {
//                             String combinedValue = "${element["bank_name"]}";
//                             allMejas.add(combinedValue);
//                           });
//                           return allMejas;
//                         } catch (e) {
//                           return e;
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 13),
//                   // TIPE MUTASI
//                   Text("Tipe Mutasi",
//                       style: TextStyle(
//                           color: darkGreen, fontWeight: FontWeight.w600)),
//                   SizedBox(height: 5),
//                   Theme(
//                     data: ThemeData(textTheme: TextTheme()),
//                     child: DropdownSearch<String>(
//                       mode: Mode.MENU,
//                       showSearchBox: true,
//                       showSelectedItems: true,
//                       popupBackgroundColor: lightGreen.withOpacity(0.97),
//                       dropdownSearchDecoration: InputDecoration(
//                         hintText: "Pilih Tipe Mutasi",
//                         labelStyle: TextStyle(color: darkGreen),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: darkGreen),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: darkGreen),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: lightGreen),
//                         ),
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 13),
//                       ),
//                       selectedItem: typeMutasiKeluar.value,
//                       onChanged: (value) {
//                         final parts = value.split(' - ');
//                         final type_mutasi = parts[0];
//                         typeMutasiKeluar.value = type_mutasi;
//                       },
//                       onFind: (text) async {
//                         var url = Server.url;
//                         var link = Uri.parse(url + "getTypeMutasiUangKeluar");
//                         try {
//                           var response = await http.get(link);
//                           List allData = (json.decode(response.body)
//                               as Map<String, dynamic>)["data"];
//                           List<String> results = [];
//                           allData.forEach((element) {
//                             String combinedValue = "${element["type_biaya"]}";
//                             results.add(combinedValue);
//                           });
//                           return results;
//                         } catch (e) {
//                           return e;
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 13),
//                   // JUMLAH
//                   Text("Jumlah Uang Keluar",
//                       style: TextStyle(
//                           color: darkGreen, fontWeight: FontWeight.w600)),
//                   SizedBox(height: 5),
//                   TextFormField(
//                     controller: jumlahUangKeluar,
//                     keyboardType: TextInputType.number,
//                     style: TextStyle(
//                         color: Colors.redAccent, fontWeight: FontWeight.w700),
//                     decoration: InputDecoration(
//                       hintText: "Masukkan jumlah",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: darkGreen),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: darkGreen),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: lightGreen),
//                       ),
//                       prefixIcon: Icon(Icons.money_off, color: darkGreen),
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 13),
//                     ),
//                     onChanged: (value) {
//                       String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
//                       if (newValue.isEmpty) {
//                         jumlahUangKeluar.text = '';
//                         return;
//                       }
//                       final formatter = NumberFormat.currency(
//                           locale: 'id_ID', symbol: '', decimalDigits: 0);
//                       String formatted = formatter.format(int.parse(newValue));
//                       jumlahUangKeluar.value = TextEditingValue(
//                         text: formatted,
//                         selection:
//                             TextSelection.collapsed(offset: formatted.length),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 13),
//                   // KETERANGAN
//                   Text("Keterangan",
//                       style: TextStyle(
//                           color: darkGreen, fontWeight: FontWeight.w600)),
//                   SizedBox(height: 5),
//                   TextFormField(
//                     controller: remarkText,
//                     maxLines: 2,
//                     style: TextStyle(color: darkGreen),
//                     decoration: InputDecoration(
//                       hintText: "Keterangan (opsional)",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: darkGreen),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: darkGreen),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: lightGreen),
//                       ),
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 13),
//                     ),
//                   ),
//                   SizedBox(height: 18),
//                   // SUBMIT
//                   SizedBox(
//                     width: double.infinity,
//                     child: Obx(() {
//                       final loading = uangKeluarController.isLoading.value;
//                       return ElevatedButton.icon(
//                         icon: loading
//                             ? SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   valueColor:
//                                       AlwaysStoppedAnimation(Colors.white),
//                                 ),
//                               )
//                             : Icon(Icons.save, color: Colors.white, size: 20),
//                         label: loading
//                             ? Text(
//                                 "Updating...",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16),
//                               )
//                             : Text(
//                                 "Update",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16),
//                               ),
//                         style: ElevatedButton.styleFrom(
//                           primary: darkGreen,
//                           elevation: 2,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16)),
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                         ),
//                         onPressed: loading
//                             ? null
//                             : () async {
//                                 if (tanggal.text.isEmpty) {
//                                   Get.snackbar(
//                                     "Validasi",
//                                     "Harap Input Tanggal",
//                                     backgroundColor: Colors.orange[700],
//                                     colorText: Colors.white,
//                                     icon: Icon(Icons.warning_amber_rounded,
//                                         color: Colors.white),
//                                     borderRadius: 14,
//                                     margin: EdgeInsets.all(16),
//                                     snackPosition: SnackPosition.TOP,
//                                   );
//                                   return;
//                                 }
//                                 final data = EditUangKeluar(
//                                   transCode: listUangKeluar.transCode,
//                                   unit: loginController.userSession['unit'],
//                                   bankName: tipePayment.value,
//                                   jumlahUangKeluar: int.tryParse(
//                                         jumlahUangKeluar.text
//                                             .replaceAll(RegExp(r'[^0-9]'), ''),
//                                       ) ??
//                                       0,
//                                   typeBiaya: typeMutasiKeluar.value,
//                                   createdDate: tanggal.text,
//                                   createBy: loginController.userSession['nama'],
//                                   remark: remarkText.text,
//                                 );

//                                 await uangKeluarController
//                                     .updateUangKeluar(data);

//                                 if (uangKeluarController.isSuccess.value) {
//                                   Get.back();
//                                   uangKeluarController.getDataUangKeluar();
//                                   Get.snackbar(
//                                     "Sukses",
//                                     "Data berhasil di update",
//                                     icon: Icon(Icons.check_circle,
//                                         color: Colors.white, size: 30),
//                                     backgroundColor:
//                                         darkGreen.withOpacity(0.93),
//                                     colorText: Colors.white,
//                                     borderRadius: 14,
//                                     margin: EdgeInsets.all(16),
//                                     snackPosition: SnackPosition.TOP,
//                                     duration: Duration(seconds: 2),
//                                   );
//                                 } else {
//                                   Get.snackbar(
//                                     "Gagal",
//                                     uangKeluarController.errorMessage.value,
//                                     backgroundColor: Colors.red[400],
//                                     colorText: Colors.white,
//                                     icon:
//                                         Icon(Icons.error, color: Colors.white),
//                                     borderRadius: 14,
//                                     margin: EdgeInsets.all(16),
//                                     snackPosition: SnackPosition.TOP,
//                                   );
//                                 }
//                               },
//                       );
//                     }),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// /// Widget info row untuk dialog
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//   final IconData icon;

//   const _InfoRow({Key key, this.label, this.value, this.icon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Color darkGreen = const Color(0xFF4C7148);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.5),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           if (icon != null)
//             Padding(
//               padding: const EdgeInsets.only(right: 8),
//               child: Icon(icon, size: 16, color: darkGreen.withOpacity(0.66)),
//             ),
//           SizedBox(
//             width: 130,
//             child: Text(
//               "$label:",
//               style: TextStyle(fontWeight: FontWeight.w600, color: darkGreen),
//             ),
//           ),
//           Expanded(
//             child: Text(value ?? "-",
//                 style: TextStyle(
//                     color: Colors.black87, fontWeight: FontWeight.w500)),
//           ),
//         ],
//       ),
//     );
//   }
// }
