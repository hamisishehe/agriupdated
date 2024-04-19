import 'package:agriconnectfinal/screens/auth/authcheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    Future.delayed(Duration(seconds: 5)).then((value) => {
      Get.off(AuthcheckPage())
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(

          child:Image.asset(
            "assets/images/logo.png",
            width: 150,
            height: 150,

          ),
        ),
      ),


    );
  }
}
