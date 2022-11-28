// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:newravelinestore/data/model/item_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  String? title;
  String? id;

  @JsonKey(defaultValue: 0)
  int pagination;

  @JsonKey(defaultValue: [])
  List<ItemModel> items;

  CategoryModel({
    this.title,
    this.id,
    required this.items,
    required this.pagination,
  });

  Map<String, dynamic> toMap() {
    return _$CategoryModelToJson(this);
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return _$CategoryModelFromJson(map);
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(title: $title, id: $id)';
}
