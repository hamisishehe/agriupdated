
import 'dart:convert';

import 'package:agriconnectfinal/contants/urls.dart';
import 'package:agriconnectfinal/screens/pages/dashboardPage.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../contants/appcolors.dart';
import 'loginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController fullname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey =  GlobalKey<FormState>();

  bool isvisible = true;
  bool isloading = false;
  Future<void> register () async{

    String registerurl = ApiUrls.mainurl+"auth/register";

    try{
      int status = 0;
      var response =  await http.post(Uri.parse(registerurl),

          body: {
            'fullname':fullname.text,
            'email':email.text,
            'role':'user',
            'password':password.text
          });
      print(registerurl);
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);

        if(responseData['message'] == "User Created Successfully"){
          final token = responseData['token'];

          // Save token in shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("usertoken", token);

          Get.offAll(DashboardPage());

          setState(() {
            isloading = false;
          });

        } else if (responseData['message']['errors']['email'] == "The email has already been taken.") {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: responseData['message'],
          );

        }
        else{
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: responseData['message'],
          );
          // Alert(context: context, title: "Error", desc: "Something Error").show();
          setState(() {
            isloading = false;
          });

        }

      }
      else {
        setState(() {
          isloading = false;
        });
        throw Exception(response.body);
      }

    }
    catch(e){
      print(e.toString());
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_color,
      body: Stack(
        children: [

          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                color: AppColors.primary_color,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(170)
                )
            ),
            child: Align(
              child: Text("Register", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: AppColors.text_white,
              ),),
            ),
          ),

          SizedBox(height: 80,),

          Container(
            margin: EdgeInsets.only(top: 350, left: 20,right: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,


            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [

                    TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Fullname Required";
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: fullname,
                      decoration: InputDecoration(
                          hintText: "Full name",
                          hintStyle: TextStyle(
                              color: AppColors.text_black
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: AppColors.primary_color,
                                child: Icon(Icons.person_2, color: AppColors.background_color, size: 20,),
                              maxRadius: 10,),
                          ),

                          focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),


                    SizedBox(height: 20,),

                    TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Email Required";
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: AppColors.text_black
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: AppColors.primary_color,
                                child: Icon(Icons.email, color: AppColors.background_color, size: 20,),
                              maxRadius: 10,
                            ),

                          ),

                          focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),



                    SizedBox(height: 20,),


                    TextFormField(
                      validator: (value) {
                        if(value!.isEmpty ){
                          return "Password Required";
                        }else if(value.length < 6){
                          return "Password Should be 6 Character long";
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isvisible,
                      controller: password,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: AppColors.text_black
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: AppColors.primary_color,
                                child: Icon(Icons.lock, color: AppColors.background_color,size: 20,),
                              maxRadius: 10,),
                          ),

                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                isvisible = !isvisible;
                              });
                            },

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: AppColors.primary_color,
                                  child: Icon(isvisible ? Icons.visibility_off : Icons.visibility, color: AppColors.background_color, size: 20,),
                                maxRadius: 10,
                              ),
                            ),
                          ),


                          focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,

                      child: ElevatedButton(

                        onPressed: (){
                          if(formkey.currentState!.validate()){
                            setState(() {
                              isloading = true;
                            });
                            register();
                          }
                          else{
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary_color,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        child: isloading ? CircularProgressIndicator(color: Colors.white,)  : Text("Register", style: TextStyle(
                            color: AppColors.text_white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),),
                    ),

                    SizedBox(height: 13,),
                    Text("have an Account?", style: TextStyle(
                        color: AppColors.text_black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                    GestureDetector(
                      onTap: (){
                        Get.to(Login_Page());
                      },
                      child: Text("Login here ", style: TextStyle(
                          color: AppColors.primary_color,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold
                      ),),
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
