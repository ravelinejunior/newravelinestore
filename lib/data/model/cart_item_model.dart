// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:newravelinestore/data/model/item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;
  CartItemModel({
    required this.item,
    required this.quantity,
  });

  double totalQuantity() => quantity * item.price;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item': item.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      item: ItemModel.fromJson(map['item'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
