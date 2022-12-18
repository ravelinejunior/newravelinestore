import 'package:flutter/material.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/domain/result/items/cart_items_result.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class CartItemsRepository {
  final _httpManager = HttpManager();

  Future<CartItemsResult<List<CartItemModel>>> getCartItems({
    required String? token,
    required String? userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: getCartItemsEndPoint,
      method: HttpAbstractMethod.post,
      headers: {'X-Parse-Session-Token': token},
      body: {'user': userId},
    );
    debugPrint(result.toString());
    if (result['result'] != null) {
      //Treat data
      final List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map((json) => CartItemModel.fromJson(json))
              .toList();

      return CartItemsResult<List<CartItemModel>>.success(data);
    } else {
      //Return message
      return CartItemsResult<List<CartItemModel>>.error(
        'Something went wrong getting the cart items',
      );
    }
  }

  Future<CartItemsResult<String>> addItemToCartRequest({
    required String userId,
    required String userToken,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: addItemToCartEndPoint,
      method: HttpAbstractMethod.post,
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
      headers: {
        'X-Parse-Session-Token': userToken,
      },
    );

    if (result['result'] != null) {
      // Add Item
      return CartItemsResult<String>.success(result['result']['id']);
    } else {
      // Error
      return CartItemsResult.error(
        'Something went wrong adding the cart items',
      );
    }
  }

  Future<bool> modifyItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: modifyItemOnCartEndPoint,
      method: HttpAbstractMethod.post,
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return result.isEmpty;
  }

  Future<CartItemsResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: checkoutEndPoint,
      method: HttpAbstractMethod.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'total': total,
      },
    );

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartItemsResult.success(order);
    } else {
      return CartItemsResult.error(
        'It was not possible finish the order. Try again',
      );
    }
  }
}
