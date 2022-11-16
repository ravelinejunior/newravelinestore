import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:newravelinestore/data/model/user_model.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/controller/user_controller.dart';
import 'package:newravelinestore/src/components/custom_text_field.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:newravelinestore/src/utils/routes.dart';

class SignupScreen extends GetView<AuthController> {
  SignupScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _cpfTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _passTextController = TextEditingController();

  final _userController = Get.find<UserController>();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final filteringPhone = [
      FilteringTextInputFormatter.digitsOnly,
      TelefoneInputFormatter()
    ];
    final filteringCpf = [
      FilteringTextInputFormatter.digitsOnly,
      CpfInputFormatter()
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal[600],
      ),
      backgroundColor: Colors.teal[600],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: LottieBuilder.asset(
                      'assets/json/grocery_shop.json',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: DefaultTextStyle(
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          FadeAnimatedText(fruitsConst),
                          FadeAnimatedText(meatsConst),
                          FadeAnimatedText(vegetablesConst),
                          FadeAnimatedText(cerealsConst),
                          FadeAnimatedText(dairiesConst),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(46),
                ),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Name',
                            inputAction: TextInputAction.next,
                            controller: _nameTextController,
                            onChanged: (value) {
                              _userController.setUserFullName(value);
                            },
                          ),
                          CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            onChanged: (value) {
                              _userController.setUserEmail(value);
                            },
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Phone',
                            inputFormatters: filteringPhone,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.phone,
                            controller: _phoneTextController,
                            onChanged: (value) {
                              _userController.setUserPhone(value);
                            },
                          ),
                          CustomTextField(
                            icon: Icons.document_scanner,
                            label: 'CPF',
                            inputFormatters: filteringCpf,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.number,
                            controller: _cpfTextController,
                            onChanged: (value) {
                              _userController.setUserCpf(value);
                            },
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Password',
                            isSelected: true,
                            inputAction: TextInputAction.done,
                            controller: _passTextController,
                            onChanged: (value) {
                              _userController.setUserPassword(value);
                            },
                          ),
                          Obx(() {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                shadowColor: Colors.greenAccent,
                                minimumSize: const Size(50, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: _authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      verifyFieldsAndSignup();
                                    },
                              child: GetX<AuthController>(
                                builder: (controller) {
                                  return controller.isLoading.value
                                      ? const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          ),
                                        )
                                      : Text(
                                          "Signup",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        );
                                },
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text('Ou'),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shadowColor: Colors.greenAccent,
                              minimumSize: const Size(50, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(
                                      color: Colors.teal,
                                      style: BorderStyle.solid,
                                      width: 1)),
                            ),
                            onPressed: () {
                              Get.toNamed(ConstantsRoutes.loginRoute);
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void verifyFieldsAndSignup() {
    final user = _userController.userModel.value;
    if (user.name?.isNotEmpty == true &&
        user.name!.isAlphabetOnly &&
        user.email?.isNotEmpty == true &&
        user.email!.isEmail &&
        user.cpf?.isNotEmpty == true &&
        user.cpf!.isCpf &&
        user.phone?.isNotEmpty == true &&
        user.phone!.isPhoneNumber &&
        user.password?.isNotEmpty == true &&
        user.password!.length > 5) {
      _signUpUser(user);
    } else {
      setErrorSnackbar(
        'Fields non filled',
        'All fields must be filled correctly',
      );
    }
  }

  _signUpUser(UserModel user) {
    controller.signUp();
    log('User signup successfully ${user.toString()}');
  }
}
