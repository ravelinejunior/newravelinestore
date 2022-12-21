import 'package:get/get.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/repository/orders/orders_repository.dart';
import 'package:newravelinestore/domain/result/orders/orders_result.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';

class OrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  List<CartItemModel> allItems = [];
  final _authController = Get.find<AuthController>();
  final _ordersRepository = OrdersRepository();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    final OrdersResult<List<OrderModel>> result =
        await _ordersRepository.getAllOrders(
      userId: _authController.mUser!.id!,
      token: _authController.mUser!.token!,
    );

    result.when(
      success: (orders) {
        allOrders = orders;
        update();
      },
      error: (errorMessage) {
        setErrorSnackbar(
          'Order Error',
          errorMessage,
        );
      },
    );
  }
}
