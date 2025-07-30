import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/model/list_all_transaction.dart';
import 'package:finance_riza/repository/list_all_transaction_repository.dart';
import 'package:get/get.dart';

class ListAllTransactionController extends GetxController {
  final ListAllTransactionRepository repository =
      Get.find<ListAllTransactionRepository>();

  LoginController loginController = Get.find<LoginController>();

  var isLoading = false.obs;
  var transactions = <TransactionData>[].obs;
  var pagination = Pagination(1, 1, 0, false, false).obs;
  var errorMessage = ''.obs;

  /// Fetch transactions for given username, supports pagination INCOME
  Future<void> fetchTransactionsIncome(String username,
      {bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        transactions.clear();
      }

      final pageToFetch = loadMore ? pagination.value.currentPage + 1 : 1;
      final result = await repository.fetchPaged(username, pageToFetch);

     

      // Filter hanya yang type == "income"
      final filteredTransactions =
          result.transactions.where((tx) => tx.type == 'income').toList();

           print(
          'Loaded page ${result.pagination.currentPage} with ${filteredTransactions.length} transactions income');

      if (loadMore) {
        transactions.addAll(filteredTransactions);
      } else {
        transactions.assignAll(filteredTransactions);
      }

      pagination.value = result.pagination;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


// TRANSFER

Future<void> fetchTransactionsTransfer(String username,
      {bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        transactions.clear();
      }

      final pageToFetch = loadMore ? pagination.value.currentPage + 1 : 1;
      final result = await repository.fetchPaged(username, pageToFetch);

     

      // Filter hanya yang type == "income"
      final filteredTransactions =
          result.transactions.where((tx) => tx.type == 'transfer').toList();

           print(
          'Loaded page ${result.pagination.currentPage} with ${filteredTransactions.length} transactions transfer');

      if (loadMore) {
        transactions.addAll(filteredTransactions);
      } else {
        transactions.assignAll(filteredTransactions);
      }

      pagination.value = result.pagination;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // expense

Future<void> fetchTransactionsExpense(String username,
      {bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        transactions.clear();
      }

      final pageToFetch = loadMore ? pagination.value.currentPage + 1 : 1;
      final result = await repository.fetchPaged(username, pageToFetch);

     

      // Filter hanya yang type == "income"
      final filteredTransactions =
          result.transactions.where((tx) => tx.type == 'expense').toList();

           print(
          'Loaded page ${result.pagination.currentPage} with ${filteredTransactions.length} transactions expense');

      if (loadMore) {
        transactions.addAll(filteredTransactions);
      } else {
        transactions.assignAll(filteredTransactions);
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

  /// Convenience to load next page
  Future<void> loadMore(String username) async {
    if (canLoadMore && !isLoading.value) {
      await fetchTransactionsIncome(username, loadMore: true);
    } else if (canLoadMore && !isLoading.value) {
      await fetchTransactionsTransfer(username, loadMore: true);
    } else if (canLoadMore && !isLoading.value) {
      await fetchTransactionsExpense(username, loadMore: true);
    }
  }
}
