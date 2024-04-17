

import 'package:agriconnectfinal/screens/pages/DetectPage.dart';
import 'package:agriconnectfinal/screens/pages/chatPage.dart';
import 'package:agriconnectfinal/screens/pages/homePage.dart';
import 'package:agriconnectfinal/screens/pages/profilePage.dart';
import 'package:flutter/material.dart';

import '../../contants/appcolors.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List pages =[
    HomePage(),
    DetectPage(),
    ChatPage(),
    ProfilePage()

  ];

  int currentIndex= 0;

  void changepage(int index){
    setState(() {
      currentIndex = index;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages.elementAt(currentIndex),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background_color,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary_color,
          unselectedItemColor: AppColors.text_black,
          onTap: changepage,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: currentIndex == 0 ?  Image.asset("assets/images/homefilled.png", width: 20,height: 20, color: AppColors.primary_color,) :
              Image.asset("assets/images/house.png", width: 20,height: 20, color: AppColors.text_black,),
              label: ""
            ),

            BottomNavigationBarItem(
                icon: currentIndex == 1 ?  Image.asset("assets/images/camera.png", width: 20,height: 20, color: AppColors.primary_color,) :
                Image.asset("assets/images/camera.png", width: 20,height: 20, color: AppColors.text_black,),
                label: ""
            ),
            BottomNavigationBarItem(
                icon: currentIndex == 2 ?  Image.asset("assets/images/commentfilled.png", width: 20,height: 20, color: AppColors.primary_color,) :
                Image.asset("assets/images/comment.png", width: 20,height: 20, color: AppColors.text_black,),
                label: ""
            ),
            BottomNavigationBarItem(
                icon: currentIndex == 3 ?  Image.asset("assets/images/userfilled.png", width: 20,height: 20, color: AppColors.primary_color,) :
                Image.asset("assets/images/user.png", width: 20,height: 20, color: AppColors.text_black,),
                label: ""
            ),
          ]),
    );
  }
}
