import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/repository/items/cart_items_repository.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';

class CartController extends GetxController {
  final cartRepository = CartItemsRepository();
  final authController = Get.find<AuthController>();

  List<CartItemModel> cartItems = [];

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

    result.when(
      success: (data) {
        cartItems = data;
        update();

        debugPrint(cartItems.toString());
      },
      error: (message) {
        setErrorSnackbar(
          'Cart Items Error',
          message,
        );
      },
    );
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalQuantity();
    }

    return total;
  }
}
