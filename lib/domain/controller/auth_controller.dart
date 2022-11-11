import 'dart:developer';

import 'package:get/get.dart';
import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/domain/repository/auth_repository.dart';
import 'package:newravelinestore/domain/result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAuthenticated = false.obs;

  final _authRepository = AuthRepository();
  late UserModel? mUser;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result =
        await _authRepository.signInAuth(email: email, password: password);
    result.when(
      success: (user) {
        //Save locally token on this first request
        isAuthenticated.value = true;
        mUser = user;
        log('User authenticated is ${user.toString()}');
      },
      error: (errorMessage) {
        isAuthenticated.value = false;
        log('Error is $errorMessage');
      },
    );

    isLoading.value = false;
  }

  Future<void> validateToken() async {
    //Get the token saved locally
  }
}
