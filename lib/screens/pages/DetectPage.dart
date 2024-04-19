import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:typewritertext/typewritertext.dart';
import '../../contants/appcolors.dart';


class DetectPage extends StatefulWidget {
  const DetectPage({Key? key}) : super(key: key);

  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  List? _outputs;
  File? _image;
  String api="AIzaSyDeKCWB_WlogQjCVhrkahFbx5gtpF3sHg4";
  bool _loading = false;
  bool isvisible = false;

  final gemini = Gemini.instance;

  String result='';
  bool isLoading = false;


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return; // Check if pickedImage is null
    setState(() {
      _loading = true;
      _image = File(pickedImage.path);
    });
    if (_image != null) { // Check if _image is not null
      setState(() {
        isLoading = true; // Show progress indicator
      });
      final file = File(pickedImage.path);
      gemini.textAndImage(
        text: "The following picture is the bean leaf so need  to classfy when bean leaf is helthy or is afftected of angular leaf spot, bean rust so when is affected by the disease so explain causes and treatment , if image is not bean leaf display the image is not related to the bean leaf and explain briefly",
        images: [file.readAsBytesSync()],
      ).then((value) {
        setState(() {
          result = value?.output ?? ''; // Update output variable with the result
          isvisible= true;
          isLoading = false;
          print(value?.output ?? '');
        });
      }).catchError((e) {
        log('textAndImageInput', error: e);
        setState(() {
          isLoading = false; // Hide progress indicator
        });
      });
      classifyImage(_image!);
    }
  }





  Future<void> classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
      isvisible = true;
    });


  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 10,top: 90, right: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: pickImage,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: _image != null
                            ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          "assets/images/camera.png",
                          scale: 8,
                          color: AppColors.primary_color,
                        ),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                     SingleChildScrollView(
        padding: EdgeInsets.only(left: 5.0,top: 10,right: 5),
        child:

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (isLoading) // Show circular progress indicator if isLoading is true
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            if (!isLoading && result.isNotEmpty) // Show output if available and not loading
              Text(
                  '${result}',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )
              ),


          ],
        ),
      ),
                ],
              ),
            ),
          ),

          Container(
            color: AppColors.primary_color,
            padding: EdgeInsets.only(top: 35, left: 10, right: 10),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detect beans Disease",
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
        ],
      ),
      
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // pickImage();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: PopupMenuButton(
          itemBuilder: (context) => <PopupMenuEntry> [
            PopupMenuItem(
              value: "Take Picture",
              child: IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt, color: AppColors.primary_color,))
            ),

            PopupMenuItem(
                value: "Take Picture",
                child: IconButton(onPressed: (){
                  pickImage();
                }, icon: Icon(Icons.photo, color: AppColors.primary_color,))
            ),

          ],
        ),
      )
    );
  }
}
