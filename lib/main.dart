import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/src/utils/routes.dart';

void main() {
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
      initialRoute: ConstantsRoutes.loginRoute,
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
