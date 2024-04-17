
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
                          return "Phone Number Required";
                        }
                      },
                      keyboardType: TextInputType.phone,
                      controller: phonenumber,
                      decoration: InputDecoration(
                          hintText: "Phonenumber",
                          hintStyle: TextStyle(
                              color: AppColors.text_black
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: AppColors.primary_color,
                                child: Icon(Icons.phone, color: AppColors.background_color, size: 20,),
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
                        if(value!.isEmpty){
                          return "Password Required";
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

                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary_color,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        child: Text("Register", style: TextStyle(
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