import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TestControllerManager extends GetxController {
  bool isLoading = false;

  Future<void> setLoading() async {
    isLoading = !isLoading;
    update();

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      isLoading = !isLoading;
      update();
    });
  }
}
