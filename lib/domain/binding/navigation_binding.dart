import 'package:get/instance_manager.dart';
import 'package:newravelinestore/domain/controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
