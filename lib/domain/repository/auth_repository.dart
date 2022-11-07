import 'dart:developer';

import 'package:newravelinestore/data/services/http_manager.dart';
import 'package:newravelinestore/src/utils/constants.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future signInAuth({
    required String email,
    required String password,
  }) async {
    final responseResult = await _httpManager.restRequest(
      url: signInEndPoint,
      method: HttpAbstractMethod.post,
      body: {'email': email, 'password': password},
    );
    if (responseResult['result'] != null) {
      log('Login succesded');
    } else {
      log('Login fail');
    }
  }
}
