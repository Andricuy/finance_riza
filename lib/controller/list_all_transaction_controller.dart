import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/model/list_all_transaction.dart';
import 'package:finance_riza/repository/list_all_transaction_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListAllTransactionController extends GetxController {
  final ListAllTransactionRepository repository =
      Get.find<ListAllTransactionRepository>();

  LoginController loginController = Get.find<LoginController>();

  var isLoading = false.obs;
var transactions = <TransactionData>[].obs;
List<TransactionData> _incomeSnapshot = [];
List<TransactionData> _expenseSnapshot = [];
List<TransactionData> _transferSnapshot = [];
  var pagination = Pagination(1, 1, 0, false, false).obs;
  var errorMessage = ''.obs;

  /// Filter transactions berdasarkan keyword di description
  void filterByDescription(String query) {
    final lower = query.toLowerCase();
    if (lower.isEmpty) {
      transactions.assignAll(_incomeSnapshot);
    } else {
      final filtered = _incomeSnapshot.where((tx) {
        final dateStr = DateFormat('yyyy-MM-dd').format(tx.date).toLowerCase();
        return (tx.source ?? '').toLowerCase().contains(lower) || dateStr.contains(lower) || (tx.description ?? '').toLowerCase().contains(lower);
      }).toList();
      transactions.assignAll(filtered);
    }
  }

  void filterByDescriptionMutasi(String query) {
    final lower = query.toLowerCase();
    if (lower.isEmpty) {
      transactions.assignAll(_transferSnapshot);
    } else {
      final filtered = _transferSnapshot.where((tx) {
        final dateStr = DateFormat('yyyy-MM-dd').format(tx.date).toLowerCase();
        return (tx.fromAccountName ?? '').toLowerCase().contains(lower) ||
               (tx.toAccountName ?? '').toLowerCase().contains(lower) || dateStr.contains(lower);
      }).toList();
      transactions.assignAll(filtered);
    }
  }


  /// Fetch transactions for given userId, supports pagination INCOME
  Future<void> fetchTransactionsIncome(int userId, {bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        transactions.clear();
        _incomeSnapshot.clear();
      }

      final pageToFetch = loadMore ? pagination.value.currentPage + 1 : 1;
      final result = await repository.fetchPaged(userId, pageToFetch);

      final filteredTransactions =
          result.transactions.where((tx) => tx.type == 'income' && tx.createdBy == userId).toList();

      if (!loadMore) {
        transactions.assignAll(filteredTransactions);
        _incomeSnapshot = List.from(filteredTransactions);
      } else {
        final newTransactions = filteredTransactions.where((tx) =>
            !_incomeSnapshot.any((existing) => existing.id == tx.id)).toList();
        transactions.addAll(newTransactions);
        _incomeSnapshot.addAll(newTransactions);
      }

      pagination.value = result.pagination;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

// TRANSFER


  Future<void> fetchTransactionsTransfer(int userId, {bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        transactions.clear();
        _transferSnapshot.clear();
      }

      final pageToFetch = loadMore ? pagination.value.currentPage + 1 : 1;
      final result = await repository.fetchPaged(userId, pageToFetch);

      final filteredTransactions =
          result.transactions.where((tx) => tx.type == 'transfer' && tx.createdBy == userId).toList();

      if (!loadMore) {
        transactions.assignAll(filteredTransactions);
        _transferSnapshot = List.from(filteredTransactions);
      } else {
        final newTransactions = filteredTransactions.where((tx) =>
            !_transferSnapshot.any((existing) => existing.id == tx.id)).toList();
        transactions.addAll(newTransactions);
        _transferSnapshot.addAll(newTransactions);
      }

      pagination.value = result.pagination;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // expense


  Future<void> fetchTransactionsExpense(int userId, {bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        transactions.clear();
        _expenseSnapshot.clear();
      }

      final pageToFetch = loadMore ? pagination.value.currentPage + 1 : 1;
      final result = await repository.fetchPaged(userId, pageToFetch);

      final filteredTransactions =
          result.transactions.where((tx) => tx.type == 'expense' && tx.createdBy == userId).toList();

      if (!loadMore) {
        transactions.assignAll(filteredTransactions);
        _expenseSnapshot = List.from(filteredTransactions);
      } else {
        final newTransactions = filteredTransactions.where((tx) =>
            !_expenseSnapshot.any((existing) => existing.id == tx.id)).toList();
        transactions.addAll(newTransactions);
        _expenseSnapshot.addAll(newTransactions);
      }

      pagination.value = result.pagination;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Determine if more pages are available
  bool get canLoadMore => pagination.value.hasNextPage;

  /// Convenience to load next page, type: 'income' | 'expense' | 'transfer'
  Future<void> loadMore(int userId, String type) async {
    if (canLoadMore && !isLoading.value) {
      if (type == 'income') {
        await fetchTransactionsIncome(userId, loadMore: true);
      } else if (type == 'transfer') {
        await fetchTransactionsTransfer(userId, loadMore: true);
      } else if (type == 'expense') {
        await fetchTransactionsExpense(userId, loadMore: true);
      }
    }
  }

  Future<void> deleteTransaction(int id, String type) async {
  try {
    isLoading.value = true;
    final success = await repository.deleteTransaction(id);
    if (success) {
      // Hapus dari snapshot dan transactions sesuai tipe
      if (type == 'income') {
        _incomeSnapshot.removeWhere((tx) => tx.id == id);
      } else if (type == 'expense') {
        _expenseSnapshot.removeWhere((tx) => tx.id == id);
      } else if (type == 'transfer') {
        _transferSnapshot.removeWhere((tx) => tx.id == id);
      }
      transactions.removeWhere((tx) => tx.id == id);
    }
  } catch (e) {
    errorMessage.value = e.toString();
  } finally {
    isLoading.value = false;
  }
}
}
