import 'dart:developer';

import 'package:get/get.dart';
import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/domain/repository/auth_repository.dart';
import 'package:newravelinestore/domain/result/auth_result.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:newravelinestore/src/utils/routes.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAuthenticated = false.obs;

  void setLoadingState() {
    isLoading.update((loading) {
      isLoading.value = !loading!;
    });
  }

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
    setLoadingState();

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

    setLoadingState();
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

  Future<void> signUp(UserModel user) async {
    mUser = user;
    setLoadingState();
    final result = await _authRepository.signUpAuth(mUser);
    result.when(
      success: (user) {
        mUser = user;
        saveTokenFromAuth();
      },
      error: (error) {
        setErrorSnackbar("Error to SignOut", error);
      },
    );

    setLoadingState();
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
    utilsService.saveLocalData(key: tokenDataKey, data: mUser!.token!);
    isAuthenticated.value = true;
    Get.offAllNamed(ConstantsRoutes.baseRoute);
    log('User authenticated is ${mUser.toString()}');
  }
}
