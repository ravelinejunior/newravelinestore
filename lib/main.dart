import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/domain/controller/auth_controller.dart';
import 'package:newravelinestore/domain/controller/navigation_controller.dart';
import 'package:newravelinestore/domain/controller/user_controller.dart';
import 'package:newravelinestore/src/utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  Get.put(AuthController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Store',
      debugShowCheckedModeBanner: false,
      initialRoute: ConstantsRoutes.splashRoute,
      getPages: Routes().getPageList,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          elevation: 0,
          centerTitle: true,
          toolbarTextStyle: GoogleFonts.montserrat(color: Colors.black87),
        ),
        textTheme: TextTheme(
          bodyText1: GoogleFonts.lato(),
          bodyText2: GoogleFonts.montserrat(),
          button: GoogleFonts.lato(color: Colors.white),
          subtitle1: GoogleFonts.montserrat(),
          subtitle2: GoogleFonts.lato(),
        ),
      ),
    );
  }
}
