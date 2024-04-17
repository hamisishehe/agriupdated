import 'package:flutter/material.dart';

import '../../contants/appcolors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Center(
            child: Text("Agri-Connect", style: TextStyle(
              color: AppColors.primary_color,
              fontSize: 40,
              fontWeight: FontWeight.bold

            ), ),
          ),

          SizedBox(
            height: 130,
          ),

          Center(
            child: Column(
              children: [
                Text("Sign in", style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold

                ), ),
                Text("Continue with Email", style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold

                ), ),

                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  margin: EdgeInsets.only(left: 40,right: 40),

                  child: ElevatedButton(

                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.text_white,
                              child: Icon(Icons.email, color: AppColors.primary_color,)),

                          SizedBox(width: 30,),
                          Text("Continue With Email", style: TextStyle(
                              color: AppColors.text_white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      )),
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}