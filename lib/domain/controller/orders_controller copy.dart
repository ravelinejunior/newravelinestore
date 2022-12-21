import 'package:get/get.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/repository/orders/items_repository.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';

class ItemsController extends GetxController {
  List<CartItemModel> allItems = [];
  final _authController = Get.find<AuthController>();
  final _itemsRepository = ItemsRepository();

  bool isItemsLoading = false;

  final OrderModel order;

  ItemsController(this.order);

  Future<void> getAllItems() async {
    setItemsLoading();
    final result = await _itemsRepository.getOrdersItems(
      orderId: order.id,
      token: _authController.mUser!.token!,
    );

    result.when(
      success: (cartItems) {
        allItems = cartItems;
        update();
      },
      error: (errorMessage) {
        setErrorSnackbar(
          'Items Error',
          errorMessage,
        );
      },
    );

    setItemsLoading();
  }

  void setItemsLoading() {
    isItemsLoading = !isItemsLoading;
    update();
  }
}
