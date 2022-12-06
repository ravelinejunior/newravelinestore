import 'package:get/get.dart';
import 'package:newravelinestore/domain/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
