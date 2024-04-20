import 'package:agriconnectfinal/contants/urls.dart';
import 'package:agriconnectfinal/model/post.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gif_view/gif_view.dart';
import 'package:http/http.dart' as http;
import '../../contants/appcolors.dart';
import 'dart:convert';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var connectivityResult;
  void checkinternet() async{
     setState(() async{
       connectivityResult = await (Connectivity().checkConnectivity());
     });
  }


  String _apiKey = 'ff4e7a8d8bc25404758f29ce677b3a40';
  String _city = 'Dodoma';
  String _weatherDescription = '';
  double _temperature = 0.0;

  double _humidity = 0.0;
  double _temp_max = 0.0;
  double _temp_min = 0.0;
  double _sea_level = 0.0;
  double _pressure = 0.0;

  String _sunrise = '';
  String _sunset = '';
  String _timezone = '';

  var imgicon;

  Future<void> _fetchWeather() async {
    final String city = 'Dodoma';
    final String url = 'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['weather'] != null && data['weather'].isNotEmpty && data['weather'][0]['description'] != null && data['main'] != null && data['main']['temp'] != null && data['main']['feels_like'] != null && data['sys'] != null &&
      data['sys']['sunrise'] != null &&
      data['sys']['sunset'] != null &&
      data['timezone'] != null) {
        setState(() {
          _weatherDescription = data['weather'][0]['description'];
          imgicon = data['weather'][0]['icon'];
          _temperature = data['main']['temp'];
          _temp_min = data['main']['feels_like'].toDouble();
          _humidity = data['main']['humidity'].toDouble(); // Convert to double
          _sunrise = _convertTimestampToTime(data['sys']['sunrise'], data['timezone']);
          _sunset = _convertTimestampToTime(data['sys']['sunset'], data['timezone']);
          _timezone = data['timezone'].toString();
        });
        print(data);
      } else {
        // Data is incomplete or invalid, handle error
        print('Error: Invalid data format');
      }
    } else {
      // HTTP request failed, handle error
      print('Error: Failed to fetch weather data');
    }
  }


  Future<List<PostModel>> getpost() async {
    var response =
    await http.get(Uri.parse("https://agriconnect.ahsoftware.site/api/updates"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PostModel.fromJson(json)).toList();

    } else {
      throw Exception('Error fetching posts');
    }
  }
  String _convertTimestampToTime(int timestamp, int timezoneOffset) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    final DateTime localDateTime = dateTime.add(Duration(seconds: timezoneOffset));
    return '${localDateTime.hour.toString().padLeft(2, '0')}:${localDateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  var hours = DateTime.now().hour;

  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.primary_color,
            padding: EdgeInsets.only(top: 35, left: 10, right: 10),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome Back!",
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

          Container(
            margin: EdgeInsets.only(left: 10,right: 10,top: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Container(
                  height: 200,
                  child: FutureBuilder<List<PostModel>>(
                      future: getpost(),
                    builder: (context, snapshot) {

                        if(snapshot.hasData){
                          return ImageSlideshow(
                            width: double.infinity,
                            initialPage: 0,
                            indicatorColor: Colors.blue,
                            indicatorBackgroundColor: Colors.grey,
                            children: snapshot.data!.map((e) {

                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage(ApiUrls.imageurl+e.image),
                                            fit: BoxFit.cover
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 128.0,left: 10),
                                    child: Column(
                                      children: [
                                        Text(e.title, style: TextStyle(
                                            color: AppColors.text_white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        SizedBox(height: 5,),
                                        Text(e.description, style: TextStyle(
                                            color: AppColors.text_white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                ],
                              );

                            }).toList(),



                            onPageChanged: (value) {
                              print('Page changed: $value');
                            },
                            autoPlayInterval: 9000,
                            isLoop: true,
                          );
                        }
                        else if(snapshot.connectionState == ConnectionState.waiting){
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("assets/images/logo.png"),
                                ),
                                borderRadius: BorderRadius.circular(20)
                            ),

                          );
                        }
                        else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'),);
                        } else {
                          return Center(child: CircularProgressIndicator(color: AppColors.primary_color,));
                        }
                      },)



                ),


              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10,right: 10,top: 320),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("overcast Clouds weather", style: TextStyle(
                      color: isDarkMode ? AppColors.text_white : AppColors.text_black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),

                  Text(
                    '$_city',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),

          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 320),
              child: Column(
                children: [

                  SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          children: [
                            Image.asset("assets/icon/humidity.png", ),
                            Text(
                              'Humidity',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '$_humidity%',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),

                        _weatherDescription == "clear sky" && _weatherDescription == "few clouds" && _weatherDescription == "scattered clouds" && _weatherDescription == "broken clouds" ?
                        imgicon == "" ? Text("") :
                        Container(
                          height: 150,
                          width: 150,
                          child:   Image.asset("assets/newicons/hali5.png", fit: BoxFit.cover,),
                        ) : imgicon == "" ? Text("") :
                        Container(
                          height: 150,
                          width: 150,
                          child:  hours>=19 && hours<=05 ? Image.asset("assets/newicons/hali5.png", fit: BoxFit.cover,) : Image.asset("assets/newicons/hali4.png", fit: BoxFit.cover,) ,
                        ),


                        Column(
                          children: [
                            Image.asset("assets/icon/temp.png", ),

                            Text(
                              'Feels like',
                              style: TextStyle(),
                            ),

                            Text(
                              '$_temp_min°C',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    '$_weatherDescription',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset("assets/icon/sunset.png", scale: 2,),
                          Text(
                            'Sunset',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '$_sunset',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),


                      Text(
                        '$_temperature\u00B0C',
                        style: TextStyle(fontSize: 64),
                      ),

                      Column(
                        children: [
                          Image.asset("assets/icon/sunrise.png"),
                          Text(
                            'Sunrise',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '$_sunrise',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),

                    ],
                  ),



                ],
              ),
            ),
          ),

        ],
      )
    );
  }
}
