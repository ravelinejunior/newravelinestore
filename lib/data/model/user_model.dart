// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'fullname')
  String name;
  String cpf;
  String email;
  String phone;
  String password;
  String token;
  String id;
  UserModel({
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.password,
    required this.token,
    required this.id,
  });

  static UserModel userModelInstance() {
    return UserModel(
      name: "",
      cpf: "",
      email: "",
      phone: "",
      password: "",
      id: "",
      token: "",
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['fullname'],
      cpf: map['cpf'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      token: map['token'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() => {
        'cpf': cpf,
        'fullname': name,
        'email': email,
        'id': id,
        'token': token,
        'phone': phone,
        'password': password,
      };

  /// Connect the generated [_$UserModelFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(name: $name, cpf: $cpf, email: $email, phone: $phone, password: $password)';
  }
}
