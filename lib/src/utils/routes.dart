import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:newravelinestore/src/screens/baseScreen/base_screen.dart';
import 'package:newravelinestore/src/screens/detailScreen/detail_screen.dart';
import 'package:newravelinestore/src/screens/loginScreen/login_screen.dart';
import 'package:newravelinestore/src/screens/profileScreen/profile_screen.dart';
import 'package:newravelinestore/src/screens/signupScreen/signup_screen.dart';
import 'package:newravelinestore/src/screens/splashScreen/splash_screen.dart';

class Routes {
  List<GetPage<dynamic>>? getPageList = [
    GetPage(
      name: ConstantsRoutes.loginRoute,
      page: () => LoginScreen(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    GetPage(
      name: ConstantsRoutes.registerRoute,
      page: () => const SignupScreen(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    GetPage(
      name: ConstantsRoutes.baseRoute,
      page: () => const BaseScreen(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    GetPage(
      name: ConstantsRoutes.detailRoute,
      page: () => const DetailScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    GetPage(
      name: ConstantsRoutes.personRoute,
      page: () => const ProfileScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    GetPage(
      name: ConstantsRoutes.splashRoute,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    /*
    GetPage(
      name: ConstantsRoutes.carDetailRoute,
      page: () => const CarDetailScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    GetPage(
      name: ConstantsRoutes.loginRoute,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    GetPage(
      name: ConstantsRoutes.searchLocationRoute,
      page: () => const SearchLocationScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.linear,
    ),
    */
  ];
}

class ConstantsRoutes {
  static const String splashRoute = "/splash";
  static const String detailRoute = "/detail";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String mainRoute = "/main";
  static const String baseRoute = "/base";
  static const String personRoute = "/person";
  static const String searchLocationRoute = "/searchLocationRoute";
}
