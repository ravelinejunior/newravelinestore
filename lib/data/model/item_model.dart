// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  String description;
  String itemName;
  String imgUrl;
  String unit;
  double price;
  ItemModel({
    required this.description,
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'itemName': itemName,
      'imgUrl': imgUrl,
      'unit': unit,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      description: map['description'] as String,
      itemName: map['itemName'] as String,
      imgUrl: map['imgUrl'] as String,
      unit: map['unit'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(description: $description, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price)';
  }
}
