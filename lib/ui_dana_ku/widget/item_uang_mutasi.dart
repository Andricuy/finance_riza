// // ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:villatte/mixins/utils.dart';
// import 'package:villatte/model/list_uang_mutasi.dart';
// import 'package:villatte/style/styles.dart';

// class ItemUangMutasi extends StatelessWidget {
//   final ListUangMutasi listUangMutasi;
//   ItemUangMutasi({this.listUangMutasi});

//   final Color darkGreen = const Color(0xFF4C7148);
//   final Color lightGreen = const Color(0xFFA3C78D);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
//       child: Card(
//         elevation: 6,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
//         color: Colors.white,
//         shadowColor: darkGreen.withOpacity(0.18),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(22),
//           onTap: () => detailTransfer(context),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Row(
//               children: [
//                 // Icon transfer
//                 Stack(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: lightGreen.withOpacity(0.16),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: darkGreen, width: 2.3),
//                         boxShadow: [
//                           BoxShadow(
//                             color: darkGreen.withOpacity(0.08),
//                             blurRadius: 8,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       padding: EdgeInsets.all(13),
//                       child: Icon(
//                         Icons.sync_alt_rounded,
//                         size: 28,
//                         color: darkGreen,
//                       ),
//                     ),
//                     if (listUangMutasi.status != "0")
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
//                 SizedBox(width: 15),
//                 // Info mutasi
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Judul
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "${listUangMutasi.asalBank} → ${listUangMutasi.keBank}",
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
//                           "Rp ${Utils.format.format(listUangMutasi.nominal)}",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                             color: darkGreen,
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
//                             "${listUangMutasi.pengeluaranDate}",
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
//                 // Arrow detail
//                 Icon(Icons.chevron_right, color: darkGreen.withOpacity(0.22)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void detailTransfer(BuildContext context) {
//     final Color darkGreen = const Color(0xFF4C7148);
//     final Color lightGreen = const Color(0xFFA3C78D);
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//           backgroundColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: lightGreen.withOpacity(0.14),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Icons.sync_alt_rounded,
//                               size: 38, color: darkGreen),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           "Detail Transfer",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: darkGreen,
//                           ),
//                         ),
//                         if (listUangMutasi.status != "0")
//                           Padding(
//                             padding: const EdgeInsets.only(top: 6),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 3),
//                               decoration: BoxDecoration(
//                                 color: Colors.green.withOpacity(0.13),
//                                 borderRadius: BorderRadius.circular(18),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Container(
//                                     child: Icon(Icons.check_circle,
//                                         color: Colors.green, size: 18),
//                                   ),
//                                   SizedBox(width: 6),
//                                   Text(
//                                     "Berhasil",
//                                     style: TextStyle(
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Divider(),
//                   // Kelompok info asal
//                   buildInfoRow("Asal Bank", listUangMutasi.asalBank,
//                       icon: Icons.account_balance),
//                   buildInfoRow("Akun Asal", listUangMutasi.asalAccount),
//                   buildInfoRow("No. Rekening Asal", listUangMutasi.asalNoRek),
//                   SizedBox(height: 8),
//                   buildInfoRow("Transfer ke Bank", listUangMutasi.keBank,
//                       icon: Icons.account_balance_wallet),
//                   buildInfoRow("Akun Tujuan", listUangMutasi.keAccount),
//                   buildInfoRow("No. Rekening Tujuan", listUangMutasi.keNoRek),
//                   Divider(),
//                   buildInfoRow("Jumlah Transfer",
//                       "Rp ${Utils.format.format(listUangMutasi.nominal)}",
//                       icon: Icons.payments),
//                   buildInfoRow("Tanggal", listUangMutasi.pengeluaranDate,
//                       icon: Icons.calendar_today_rounded),
//                   buildInfoRow("Unit", listUangMutasi.unit,
//                       icon: Icons.home_work_outlined),
//                   SizedBox(height: 12),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                           backgroundColor: lightGreen.withOpacity(0.14),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12))),
//                       child: Text("Tutup",
//                           style: TextStyle(
//                               color: darkGreen, fontWeight: FontWeight.bold)),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget buildInfoRow(String label, String value, {IconData icon}) {
//     final Color darkGreen = const Color(0xFF4C7148);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3.5),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Padding(
//               padding: const EdgeInsets.only(right: 8, top: 2),
//               child: Icon(icon, size: 16, color: darkGreen.withOpacity(0.66)),
//             ),
//           SizedBox(
//             width: 120,
//             child: Text(
//               "$label:",
//               style: TextStyle(fontWeight: FontWeight.w600, color: darkGreen),
//             ),
//           ),
//           Expanded(
//             child: Text(value ?? "-", style: TextStyle(color: Colors.black87)),
//           ),
//         ],
//       ),
//     );
//   }
// }
