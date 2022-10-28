import 'package:get/get.dart';

class TestControllerManager extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> setLoading() async {
    isLoading.value = !isLoading.value;
    update();

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      isLoading.value = !isLoading.value;
      update();
    });
  }
}
