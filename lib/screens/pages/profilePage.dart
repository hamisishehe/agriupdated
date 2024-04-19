
import 'dart:convert';

import 'package:agriconnectfinal/contants/urls.dart';
import 'package:agriconnectfinal/model/user.dart';
import 'package:agriconnectfinal/screens/auth/loginPage.dart';
import 'package:agriconnectfinal/screens/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../contants/appcolors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late String token;

  Future<void> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("usertoken")!;
    });
  }


  Future<void> logout() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Get.offAll(WelcomeScreen());
  }

  Future<UserModel> userprofile() async {
    String profileurl = ApiUrls.mainurl+"user/profile";

    var response = await http.get(
      Uri.parse(profileurl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
      return UserModel.fromJson(user);
      print(user);
    } else {
      throw Exception(response.statusCode);
    }
    print("token is $token");
  }


  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }
  Future<void> _initializeProfile() async {
    await getToken();
    await userprofile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primary_color,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0, left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      maxRadius: 15,
                      backgroundColor: AppColors.primary_color,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.only(top: 68.0),
                      child: FutureBuilder<UserModel>(
                        future: userprofile(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return    Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.fullname, style: TextStyle(
                                    color: AppColors.text_black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 3,),
                                Text(snapshot.data!.email, style: TextStyle(
                                    color: AppColors.text_black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 6,),

                              ],
                            );
                          }
                          else {
                            return Text("");
                          }

                        },),
                    ),
                    Spacer(),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            backgroundColor:AppColors.primary_color
                        ),
                        onPressed: (){}, child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.edit, color: AppColors.text_white,),
                          Text("Edit Profile", style: TextStyle(
                              color: AppColors.text_white,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),),
                    ),
                  ],
                ),
              ),
            ),




            SizedBox(height: 5,),
            ListTile(
              autofocus: true,
              title:  Text("Overview", style: TextStyle(
                  color: AppColors.text_black.withOpacity(0.5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
              trailing: Text("Overview", style: TextStyle(
                  color: AppColors.text_black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
            ),

            ListTile(
                autofocus: true,
                title:  Text("Settings", style: TextStyle(
                    color: AppColors.text_black.withOpacity(0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                trailing: Icon(Icons.arrow_forward_ios)
            ),
            ListTile(
                autofocus: true,
                title:  Text("FAQ's", style: TextStyle(
                    color: AppColors.text_black.withOpacity(0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                trailing: Icon(Icons.arrow_forward_ios)
            ),
            ListTile(
              onTap: (){
                logout();
              },
                autofocus: true,
                title:  Text("Logout", style: TextStyle(
                    color: AppColors.text_black.withOpacity(0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                trailing: Icon(Icons.arrow_forward_ios)
            ),

          ],
        ),
      ),
    );
  }
}
