import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:newravelinestore/domain/manager/test_manager.dart';
import 'package:newravelinestore/src/components/custom_text_field.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:newravelinestore/src/utils/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final testController = TestControllerManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[600],
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.6,
                    child: LottieBuilder.asset(
                      'assets/json/grocery_check.json',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(46),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTextField(icon: Icons.email, label: 'Email'),
                    const CustomTextField(
                      icon: Icons.lock,
                      label: 'Password',
                      isSelected: true,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          shadowColor: Colors.greenAccent,
                          minimumSize: const Size(50, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          testController.setLoading().then(
                                (value) => Get.offAndToNamed(
                                    ConstantsRoutes.baseRoute),
                              );
                        },
                        child: GetBuilder<TestControllerManager>(
                          init: testController,
                          builder: (controller) {
                            return controller.isLoading
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator.adaptive(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : Text(
                                    "Login",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                          },
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          forgotPassword,
                          style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {},
                      ),
                    ),
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
                        Get.toNamed(ConstantsRoutes.registerRoute);
                      },
                      child: Text(
                        "Signup",
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
            ),
          )
        ],
      ),
    );
  }
}
