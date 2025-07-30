import 'package:get/get.dart';

class LoadingButtonController extends GetxController {
  
  RxBool isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}