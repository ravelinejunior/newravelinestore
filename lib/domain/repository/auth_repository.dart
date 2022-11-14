import 'dart:developer';

import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/domain/repository/auth_errors.dart'
    // ignore: library_prefixes
    as authErrors;
import 'package:newravelinestore/domain/result/auth_result.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> signInAuth({
    required String email,
    required String password,
  }) async {
    final responseResult = await _httpManager.restRequest(
      url: signInEndPoint,
      method: HttpAbstractMethod.post,
      body: {'email': email, 'password': password},
    );

    if (responseResult['result'] != null) {
      log('Login successfully authenticated');
      final user = UserModel.fromMap(responseResult['result']);
      return AuthResult.success(user);
    } else {
      log('Login fail');
      return AuthResult.error(
        authErrors.authErrorsString(
          responseResult['error'],
        ),
      );
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final response = await _httpManager.restRequest(
        url: validateTokenEndPoint,
        method: HttpAbstractMethod.get,
        headers: {'X-Parse-Session-Token': token});

    if (response['result'] != null) {
      log('Login successfully authenticated');
      final user = UserModel.fromMap(response['result']);
      return AuthResult.success(user);
    } else {
      log('Login fail');
      return AuthResult.error(
        authErrors.authErrorsString(
          response['error'],
        ),
      );
    }
  }
}
