import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:newravelinestore/src/components/custom_text_field.dart';
import 'package:newravelinestore/src/utils/constants.dart';
import 'package:newravelinestore/src/utils/routes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CustomTextField(
                          icon: Icons.person,
                          label: 'Name',
                          inputAction: TextInputAction.next,
                        ),
                        const CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            inputAction: TextInputAction.next),
                        CustomTextField(
                          icon: Icons.phone,
                          label: 'Phone',
                          inputFormatters: filteringPhone,
                          inputAction: TextInputAction.next,
                        ),
                        CustomTextField(
                          icon: Icons.document_scanner,
                          label: 'CPF',
                          inputFormatters: filteringCpf,
                          inputAction: TextInputAction.next,
                        ),
                        const CustomTextField(
                          icon: Icons.lock,
                          label: 'Password',
                          isSelected: true,
                          inputAction: TextInputAction.done,
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
                          onPressed: () {},
                          child: Text(
                            "Signup",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
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
