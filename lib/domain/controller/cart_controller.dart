import 'package:get/get.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/repository/items/cart_items_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartItemsRepository();
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  Future<void> getCartItems() async {
    final result = await cartRepository.getCartItems(
      token: authController.mUser?.token,
      userId: authController.mUser?.id,
    );
  }
}
