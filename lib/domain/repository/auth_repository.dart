import 'dart:developer';

import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/domain/result/auth_result.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:newravelinestore/domain/repository/auth_errors.dart'
    as authErrors;

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
      log(responseResult['result']);
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
}
