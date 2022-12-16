import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/model/item_model.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/repository/items/cart_items_repository.dart';
import 'package:newravelinestore/domain/result/items/cart_items_result.dart';
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
      },
      error: (message) {
        setErrorSnackbar(
          'Cart Items Error',
          message,
        );
      },
    );
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    final int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      //Item already exists
      final product = cartItems[itemIndex];
      await modifyItemQuantity(
        cartItem: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      //Doesnt exists

      final user = authController.mUser!;

      final CartItemsResult<String> result =
          await cartRepository.addItemToCartRequest(
        userId: user.id.toString(),
        userToken: user.token.toString(),
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(id: cartItemId, item: item, quantity: quantity),
          );
        },
        error: (message) {
          setErrorSnackbar('Add Cart Error', message);
        },
      );
    }

    update();
  }

  Future<bool> modifyItemQuantity(
      {required CartItemModel cartItem, required int quantity}) async {
    final user = authController.mUser!;
    final result = await cartRepository.modifyItemQuantity(
      token: user.token.toString(),
      cartItemId: cartItem.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere(
          (item) => cartItem.id == item.id,
        );
      } else {
        cartItems
            .firstWhere(
              (item) => cartItem.id == item.id,
            )
            .quantity = quantity;
      }

      update();
    } else {
      setErrorSnackbar(
        'Modifying Error',
        'Something went wrong while changing quantity',
      );
    }

    return result;
  }

  int getItemIndex(ItemModel item) =>
      cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalQuantity();
    }

    return total;
  }

  int getCartTotalItems() => cartItems.isEmpty
      ? 0
      : cartItems.map((cartItem) => cartItem.quantity).reduce((a, b) => a + b);

  int getCartTotalItem() => cartItems.isEmpty ? 0 : cartItems.length;
}
