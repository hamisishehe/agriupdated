import 'package:agriconnectfinal/contants/appcolors.dart';
import 'package:agriconnectfinal/screens/auth/loginPage.dart';
import 'package:agriconnectfinal/screens/auth/welcome.dart';
import 'package:agriconnectfinal/screens/pages/dashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthcheckPage extends StatefulWidget {
  const AuthcheckPage({super.key});

  @override
  State<AuthcheckPage> createState() => _AuthcheckPageState();
}

class _AuthcheckPageState extends State<AuthcheckPage> {



  Future<bool> check() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("usertoken");
    return token != null;
  }

  @override
  initState()  {
    // TODO: implement initState
    check().then((isloggedin) {
      if (isloggedin) {
        Get.offAll(DashboardPage());
      }
      else{
        Get.offAll(WelcomeScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: AppColors.primary_color,),
      ),

    );
  }
}
