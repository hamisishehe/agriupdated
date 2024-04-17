import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contants/appcolors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

  GlobalKey<FormState> formkey =  GlobalKey<FormState>();

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
              child: Text("Reset Password", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: AppColors.text_white,
              ),),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 28),
              child: CircleAvatar(
                  backgroundColor: AppColors.background_color,
                  child: Icon(Icons.arrow_back_ios, color: AppColors.primary_color,))
            ),
          ),

          SizedBox(height: 80,),

          Container(
            margin: EdgeInsets.only(top: 350, left: 20,right: 20),
            width: MediaQuery.of(context).size.width,
            height: 300,


            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [

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
                                child: Icon(Icons.email, color: AppColors.background_color,)),
                          ),

                          focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 3),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary_color, width: 3),
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),

                    SizedBox(height: 20,),


                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,

                      child: ElevatedButton(

                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary_color,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        child: Text("Reset Password", style: TextStyle(
                            color: AppColors.text_white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),),
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
