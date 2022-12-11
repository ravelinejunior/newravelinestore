// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:newravelinestore/data/model/item_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  String id;

  @JsonKey(name: 'product')
  ItemModel item;

  int quantity;

  CartItemModel({
    required this.id,
    required this.item,
    required this.quantity,
  });

  double totalQuantity() => quantity * item.price;

  Map<String, dynamic> toJson() {
    return _$CartItemModelToJson(this);
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return _$CartItemModelFromJson(json);
  }
}
