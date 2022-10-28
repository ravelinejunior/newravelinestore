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
      user?.password = userPass;
    });
  }
}
