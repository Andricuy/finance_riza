// ignore_for_file: prefer_const_constructors

import 'package:finance_riza/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SaveLoginController extends GetxController{
  
  // SAVE LOGIN

 final GetStorage box = GetStorage();

  // Observables for UI/data binding
  final RxBool rememberMe = false.obs;
  final RxList<String> savedUsernames = <String>[].obs;
  final RxMap<String, String> savedPasswords = <String, String>{}.obs;

  // Controllers for current input
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// Loads saved usernames and passwords from GetStorage.
  void loadSavedLogins() {
    try {
      final usernamesRaw = box.read<List>('saved_usernames');
      final passwordsRaw = box.read<Map>('saved_passwords');

      savedUsernames.value = (usernamesRaw?.cast<String>() ?? []).toSet().toList();
      savedPasswords.value = Map<String, String>.from(passwordsRaw ?? {});
    } catch (e) {
      savedUsernames.value = [];
      savedPasswords.value = {};
    }
  }

  /// Saves a login. Will update password if username already exists.
  void saveLogin(String username, String password) {
    if (username.isEmpty) return;
    if (!savedUsernames.contains(username)) {
      savedUsernames.add(username);
    }
    savedPasswords[username] = password;
    // Save to persistent storage
    box.write('saved_usernames', savedUsernames.toList());
    box.write('saved_passwords', savedPasswords.cast<String, String>());
  }

  /// Removes a saved login entry.
  void deleteLogin(String username) {
    savedUsernames.remove(username);
    savedPasswords.remove(username);
    box.write('saved_usernames', savedUsernames.toList());
    box.write('saved_passwords', savedPasswords.cast<String, String>());
  }

  /// Checks if login is already saved, if not, prompts dialog to save.
  Future<void> checkAndAskToSaveLogin(String username, String password) async {
    final exists = savedPasswords.containsKey(username);
    if (!exists) {
      final result = await Get.dialog<bool>(
        AlertDialog(
          title: Text("Simpan Login?"),
          content: Text("Simpan username dan password ini untuk login selanjutnya?"),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text("Ya"),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      if (result == true) {
        saveLogin(username, password);
        Get.snackbar("Disimpan", "Login berhasil disimpan", backgroundColor: Colors.green[50]);
      } else {
        Get.snackbar("Info", "Login tidak disimpan", backgroundColor: Colors.orange[50]);
      }
    }
  }

  /// Fills the controllers with the selected login data.
  void onUsernameSelected(String username) {
    usernameController.text = username;
    passwordController.text = savedPasswords[username] ?? '';
  }

   /// Shows a robust dialog to select/delete saved logins.
  Future<void> showSavedLogins({BuildContext context}) async {
    // Defensive update: reload from storage
    loadSavedLogins();

    await Get.dialog(
      Obx(() {
        final list = savedUsernames;
        return AlertDialog(
          title: Text("Pilih Akun Tersimpan"),
          content: list.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Belum ada akun tersimpan.", style: TextStyle(color: Colors.grey[600])),
                )
              : SizedBox(
                  height: ((list.length * 60.0).clamp(70.0, 260.0)).toDouble(), // FIXED: always double
                  width: double.maxFinite,
                  child: ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => Divider(height: 1),
                    itemBuilder: (_, i) {
                      final username = list[i];
                      final password = savedPasswords[username] ?? '';
                      return ListTile(
                        leading: Icon(Icons.person, color: AppStyles.colorDasar),
                        title: Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: password.isNotEmpty
                            ? Text('●' * password.length, style: TextStyle(letterSpacing: 2, color: Colors.grey))
                            : Text('(Tidak ada password)', style: TextStyle(fontSize: 11, color: Colors.redAccent)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red[300]),
                          tooltip: 'Hapus akun ini',
                          onPressed: () async {
                            final ok = await Get.dialog<bool>(
                              AlertDialog(
                                title: Text("Hapus Akun"),
                                content: Text("Yakin hapus login '$username'?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: Text("Batal"),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(result: true),
                                    child: Text("Hapus", style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                              barrierDismissible: true,
                            );
                            if (ok == true) {
                              deleteLogin(username);
                              Get.snackbar("Dihapus", "Akun $username dihapus.", backgroundColor: Colors.red[50]);
                            }
                          },
                        ),
                        onTap: () {
                          onUsernameSelected(username);
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("Tutup")),
          ],
        );
      }),
      barrierDismissible: true,
    );
  }
}