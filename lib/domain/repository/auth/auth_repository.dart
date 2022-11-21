import 'dart:developer';

import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/domain/repository/auth/auth_errors.dart';
import 'package:newravelinestore/domain/result/auth/auth_result.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> signInAuth({
    required String email,
    required String password,
  }) async {
    final response = await _httpManager.restRequest(
      url: signInEndPoint,
      method: HttpAbstractMethod.post,
      body: {'email': email, 'password': password},
    );

    return handleUserOrError(response);
  }

  Future<AuthResult> validateToken(String token) async {
    final response = await _httpManager.restRequest(
        url: validateTokenEndPoint,
        method: HttpAbstractMethod.post,
        headers: {'X-Parse-Session-Token': token});

    return handleUserOrError(response);
  }

  Future<AuthResult> signUpAuth(UserModel? user) async {
    final result = await _httpManager.restRequest(
      url: signUpEndPoint,
      method: HttpAbstractMethod.post,
      body: user?.toJson(),
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: resetPasswordEndPoint,
      method: HttpAbstractMethod.post,
      body: {'email': email},
    );
  }

  AuthResult handleUserOrError(Map<dynamic, dynamic> response) {
    if (response['result'] != null) {
      log('Login successfully authenticated');
      final user = UserModel.fromJson(response['result']);
      return AuthResult.success(user);
    } else {
      log('Login fail');
      return AuthResult.error(
        authErrorsString(
          response['error'],
        ),
      );
    }
  }
}
