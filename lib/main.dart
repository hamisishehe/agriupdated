import 'package:agriconnectfinal/binding/networks_bindings.dart';
import 'package:agriconnectfinal/contants/appcolors.dart';
import 'package:agriconnectfinal/controller/injection.dart';
import 'package:agriconnectfinal/screens/auth/loginPage.dart';
import 'package:agriconnectfinal/screens/auth/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyDeKCWB_WlogQjCVhrkahFbx5gtpF3sHg4');
  Injection.init();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: NetworkBindings(),
      debugShowCheckedModeBanner: false,
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
