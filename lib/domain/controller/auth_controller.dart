import 'package:get/get.dart';
import 'package:newravelinestore/domain/repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAuthenticated = false.obs;

  final _authRepository = AuthRepository();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    await _authRepository.signInAuth(email: email, password: password).then(
          (isAuth) => isAuthenticated.value = isAuth,
        );

    isLoading.value = false;
  }
}
