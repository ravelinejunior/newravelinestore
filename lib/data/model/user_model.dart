// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String name;
  String cpf;
  String email;
  String phone;
  String password;
  UserModel({
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.password,
  });

  UserModel copyWith({
    String? name,
    String? cpf,
    String? email,
    String? phone,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, cpf: $cpf, email: $email, phone: $phone, password: $password)';
  }
}
