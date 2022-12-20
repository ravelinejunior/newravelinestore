import 'package:get/instance_manager.dart';
import 'package:newravelinestore/domain/controller/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersController());
  }
}
