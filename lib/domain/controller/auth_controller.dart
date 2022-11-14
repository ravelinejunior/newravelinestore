import 'dart:developer';

import 'package:get/get.dart';
import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/domain/repository/auth_repository.dart';
import 'package:newravelinestore/domain/result/auth_result.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:newravelinestore/src/utils/routes.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAuthenticated = false.obs;

  final _authRepository = AuthRepository();
  late UserModel? mUser;

  final utilsService = UtilsService();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

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
        mUser = user;
        saveTokenFromAuth();
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
    String? token = await utilsService.getLocalData(key: tokenDataKey);
    if (token == null) {
      isAuthenticated.value = false;
      Get.offAllNamed(ConstantsRoutes.loginRoute);
      return;
    } else {
      final AuthResult result = await _authRepository.validateToken(token);

      result.when(
        success: (user) {
          mUser = user;
          saveTokenFromAuth();
        },
        error: (msg) {
          //Logout user from application
          signOut();
        },
      );
    }
  }

  Future<void> signOut() async {
    //Delete user
    mUser = UserModel.userModelInstance();
    //Remove local token
    await utilsService.removeLocalData(key: tokenDataKey);

    //Go to Login Screen
    Get.offAllNamed(ConstantsRoutes.loginRoute);
  }

  void saveTokenFromAuth() {
    //Save Data
    utilsService.saveLocalData(key: tokenDataKey, data: mUser!.token);
    isAuthenticated.value = true;
    Get.offAllNamed(ConstantsRoutes.baseRoute);
    log('User authenticated is ${mUser.toString()}');
  }
}
