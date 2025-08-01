import 'package:finance_riza/model/transaction.dart';
import 'package:finance_riza/repository/transaction_repository.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final TransactionRepository transactionRepository = Get.find<TransactionRepository>();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<bool> createIncome(Transaction trx) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await transactionRepository.createTransaksi(trx);
      isLoading.value = false;
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> createMutasi(Transaction trx) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await transactionRepository.createTransaksi(trx);
      isLoading.value = false;
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> createExpense(Transaction trx) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await transactionRepository.createTransaksi(trx);
      isLoading.value = false;
      return true;
    } catch (e) {
      print('Error creating expense: $e');
      errorMessage.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }


  
}
