import 'dart:developer';

import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<bool> signInAuth({
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
      return true;
    } else {
      log('Login fail');
      return false;
    }
  }
}
