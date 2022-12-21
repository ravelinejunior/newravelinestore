// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:newravelinestore/data/model/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? dateCreated;

  @JsonKey(name: 'due')
  DateTime dateOverdue;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;

  String status;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;

  bool get isOverDue => dateOverdue.isBefore(DateTime.now().toLocal());

  double total;
  String qrCodeImage;
  OrderModel({
    required this.id,
    required this.dateCreated,
    required this.dateOverdue,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    required this.qrCodeImage,
  });

  Map<String, dynamic> toMap() {
    return _$OrderModelToJson(this);
  }

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return _$OrderModelFromJson(map);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'OrderModel(id: $id, dateCreated: $dateCreated, dateOverdue: $dateOverdue, items: $items, status: $status, copyAndPaste: $copyAndPaste, total: $total)';
  }
}
