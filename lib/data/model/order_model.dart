// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:newravelinestore/data/model/cart_item_model.dart';

class OrderModel {
  int id;
  DateTime dateCreated;
  DateTime dateOverdue;
  List<CartItemModel> items;
  String status;
  String copyAndPaste;
  double total;
  OrderModel({
    required this.id,
    required this.dateCreated,
    required this.dateOverdue,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'dateOverdue': dateOverdue.millisecondsSinceEpoch,
      'items': items.map((x) => x.toJson()).toList(),
      'status': status,
      'copyAndPaste': copyAndPaste,
      'total': total,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'OrderModel(id: $id, dateCreated: $dateCreated, dateOverdue: $dateOverdue, items: $items, status: $status, copyAndPaste: $copyAndPaste, total: $total)';
  }
}
