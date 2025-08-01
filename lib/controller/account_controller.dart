import 'package:finance_riza/model/account.dart';
import 'package:finance_riza/repository/chart_account_repository.dart';
import 'package:get/get.dart';
import 'dart:convert';

class AccountController extends GetxController {
  ChartAccountRepository chartAccountRepository =
      Get.find<ChartAccountRepository>();
  var assets = <Account>[].obs;
  var revenues = <Account>[].obs;
  var expenses = <Account>[].obs;
  var liabilities = <Account>[].obs;
  var equities = <Account>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var accountCode = ''.obs;
  var balance = 0.0.obs;
  var chartAccountData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssets();
    fetchRevenues();
  }

  Future<void> fetchAssets() async {
    isLoading.value = true;
    try {
      assets.value = await chartAccountRepository.fetchByCategory('asset');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRevenues() async {
    isLoading.value = true;
    try {
      revenues.value = await chartAccountRepository.fetchByCategory('revenue');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchExpanse() async {
    isLoading.value = true;
    try {
      expenses.value = await chartAccountRepository.fetchByCategory('expense');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLiability() async {
    isLoading.value = true;
    try {
      liabilities.value =
          await chartAccountRepository.fetchByCategory('liability');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEquity() async {
    isLoading.value = true;
    try {
      equities.value = await chartAccountRepository.fetchByCategory('equity');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void fetchChartAccountCode(String code) async {
    isLoading(true);
    chartAccountRepository.fetchChartAcountCode(code).then((response) {
      var content = json.decode(response);
      if (content == null) {
        accountCode.value = '';
        balance.value = 0;
        chartAccountData.value = {'account_code': '', 'balance': 0};
      } else {
        accountCode.value = content["account_code"] ?? '';
        balance.value =  (content["balance"] ?? 0).toDouble();
      }
      isLoading(false);
    }).catchError((err, track) {
      errorMessage.value = err.toString();
      accountCode.value = '';
      balance.value = 0;
      chartAccountData.value = {'account_code': '', 'balance': 0};
      isLoading(false);
    });
  }
}
