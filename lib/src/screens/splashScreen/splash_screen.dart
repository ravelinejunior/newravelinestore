import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade500,
              Colors.teal,
              Colors.teal[700] as Color,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text.rich(
                TextSpan(
                  style: GoogleFonts.montserrat(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Raveline',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Grocery',
                      style: GoogleFonts.montserrat(
                        color: Colors.red[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            LottieBuilder.asset(
              'assets/json/splash.json',
              alignment: Alignment.center,
              animate: true,
              options: LottieOptions(
                enableMergePaths: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
