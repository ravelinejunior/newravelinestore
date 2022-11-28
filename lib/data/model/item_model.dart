// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;
  String description;
  @JsonKey(name: 'title')
  String itemName;
  @JsonKey(name: 'picture')
  String imgUrl;
  String unit;
  double price;
  ItemModel({
    this.id = '',
    required this.description,
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return _$ItemModelToJson(this);
  }

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return _$ItemModelFromJson(map);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ItemModel(id: $id, description: $description, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price)';
  }
}
