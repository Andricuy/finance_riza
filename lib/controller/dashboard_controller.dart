import 'dart:convert';
import 'package:get/get.dart';
import 'package:finance_riza/model/transaction_data.dart';
import 'package:finance_riza/repository/dashboard_repository.dart';
import 'package:finance_riza/controller/login_controller.dart';

class DashboardController extends GetxController {
  // Loading & error state
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Statistik
  var monthlyIncome = 0.obs;
  var monthlyExpense = 0.obs;
  var totalBalance = 0.obs;
  var monthlyTransactionCount = 0.obs;

  // List transaksi
  var transactions = <TransactionData>[].obs;

  // Dependencies
  final DashboardRepository dashboardRepository = Get.find<DashboardRepository>();
  final LoginController loginController = Get.find<LoginController>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   loadDashboard();
  // }

  /// Load data dashboard langsung dari JSON string
  void loadDashboard() async {
    try {
      isLoading(true);
      errorMessage('');

      // Fetch raw JSON response as string
      String response = await dashboardRepository.fetchRecentTransactions(
        loginController.userSession['username'],
      );

      // Decode JSON
      final Map<String, dynamic> content = json.decode(response);

      if (content['data'] == null) {
        errorMessage('Data tidak ada');
        print('data tidak ada');
        return;
      }

      final data = content['data'] as Map<String, dynamic>;

      // Assign statistik
      monthlyIncome.value = data['monthlyIncome'] ?? 0;
      monthlyExpense.value = data['monthlyExpense'] ?? 0;
      totalBalance.value = data['totalBalance'] ?? 0;
      monthlyTransactionCount.value = data['monthlyTransactionCount'] ?? 0;

      // Assign list transaksi menggunakan helper
      final List<TransactionData> listTx = transactionDataFromJson(response);
      transactions.assignAll(listTx);

      // Debug prints
      print('Stats: Income=${monthlyIncome.value}, Expense=${monthlyExpense.value}, Balance=${totalBalance.value}, Count=${monthlyTransactionCount.value}');
      print('Loaded ${transactions.length} transactions');

    } catch (e) {
      errorMessage(e.toString());
      print('Error loading dashboard: $e');
    } finally {
      isLoading(false);
    }
  }
}

/// Helper untuk parse recentTransactions dari JSON string
List<TransactionData> transactionDataFromJson(String response) {
  final Map<String, dynamic> jsonData = json.decode(response);
  final data = jsonData['data'] as Map<String, dynamic>;
  if (data == null) return [];

  final list = data['recentTransactions'] as List<dynamic>;
  if (list == null) return [];

  return list
      .map((x) => TransactionData.fromJson(x as Map<String, dynamic>))
      .toList();
}
