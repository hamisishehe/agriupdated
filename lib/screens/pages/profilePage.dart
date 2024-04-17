
import 'package:flutter/material.dart';

import '../../contants/appcolors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                      child: Column(
                        children: [
                          Text("Full name", style: TextStyle(
                              color: AppColors.text_black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 3,),
                          Text("+255653918817", style: TextStyle(
                              color: AppColors.text_black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 6,),




                        ],
                      ),
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
