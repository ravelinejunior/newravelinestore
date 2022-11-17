import 'package:get/get.dart';
import 'package:newravelinestore/data/model/user_model.dart';

class UserController extends GetxController {
  Rx<UserModel> userModel = UserModel.userModelInstance().obs;

  void setUserEmail(String userEmail) {
    userModel.update((user) {
      user?.email = userEmail;
    });

    //Another way
    // userModel.value.email = userEmail;
    // userModel.refresh();
  }

  void setUserPassword(String userPass) {
    userModel.update((user) {
      user?.password = userPass.trim();
    });
  }

  void setUserCpf(String userCpf) {
    userModel.update((user) {
      user?.cpf = userCpf.trim();
    });
  }

  void setUserPhone(String userPhone) {
    userModel.update((user) {
      user?.phone = userPhone.trim();
    });
  }

  void setUserFullName(String userName) {
    userModel.update((user) {
      user?.name = userName.trim();
    });
  }

  void clearUser() {
    userModel.value = UserModel.userModelInstance();
    userModel.refresh();
  }
}
