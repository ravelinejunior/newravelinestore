import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/controller/user_controller.dart';
import 'package:newravelinestore/src/components/custom_text_field.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final emailController = TextEditingController();
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();

  ForgotPasswordDialog({
    required String email,
    Key? key,
  }) : super(key: key) {
    emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                // Descrição
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    'Digite seu email para recuperar sua senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),

                // Campo de email
                CustomTextField(
                  controller: emailController,
                  icon: Icons.email,
                  label: 'Email',
                ),

                // Confirmar
                Obx(
                  () {
                    return !authController.isLoading.value
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    resetPass();
                                  },
                            child: const Text(
                              'Recuperar',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),

          // Botão para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }

  void resetPass() {
    final user = userController.userModel.value;
    if (user.email!.isNotEmpty && user.email!.isEmail) {
      authController.resetPassword(user.email!);
      Get.back(result: true);
    } else {
      setErrorSnackbar(
        'Email not found',
        'Type the email to send a reset request man!',
      );
    }
  }
}
