import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return; // Check if pickedImage is null
    setState(() {
      _loading = true;
      _image = File(pickedImage.path);
    });
    if (_image != null) { // Check if _image is not null
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
                children: [
                  InkWell(
                    onTap: pickImage,
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
                  SizedBox(
                    height: 5,
                  ),
                  _loading
                      ? Center(child: CircularProgressIndicator())
                      : _outputs != null
                      ? _outputs![0]["confidence"] > 0.5 // Check if confidence is high enough
                      ? Text(
                    "${_outputs![0]["label"]} Confidence: ${(_outputs![0]["confidence"] * 100).toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      backgroundColor: Colors.white,
                    ),
                  )
                      : Text(
                    "Unable to detect",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      backgroundColor: Colors.white,
                    ),
                  )
                      : Container(),


                  Visibility(
                    visible: isvisible,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                      Visibility(
                        visible: isvisible,
                        child: TypeWriterText(
                        text: Text(
                        'Angular Leaf Spot of Beans:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        duration: Duration(milliseconds: 50),
                                          ),
                      ),

                          SizedBox(height: 16.0),
                      TypeWriterText(
                        text: Text(
                          'Angular leaf spot is a common bacterial disease affecting beans (Phaseolus vulgaris) and other related crops. It is characterized by small, angular lesions on the leaves, which eventually enlarge and coalesce, leading to defoliation and reduced yield.',
                        ),
                        duration: Duration(milliseconds: 50),
                      ),

                          SizedBox(height: 16.0),
                          Text(
                            'Causes:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                      TypeWriterText(
                        text: Text(
                          'Angular leaf spot is caused by the bacterium Pseudomonas syringae pv. phaseolicola. This bacterium thrives in warm, humid conditions and can survive in crop debris or on infected seeds. It spreads through splashing water, wind, and farming tools, facilitating its transmission within and between fields.',
                        ),
                        duration: Duration(milliseconds: 50),
                      ),

                          SizedBox(height: 16.0),
                          Text(
                            'Treatment:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Cultural Practices:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('- Crop Rotation: Rotate beans with non-host crops to reduce pathogen buildup in the soil.'),
                          Text('- Sanitation: Remove and destroy infected plant debris to prevent the spread of the bacteria.'),
                          Text('- Avoid Overhead Irrigation: Minimize splashing water, as it helps in the dissemination of the bacteria.'),
                          SizedBox(height: 16.0),
                          Text(
                            'Chemical Control:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('- Copper-based Fungicides: Copper-based fungicides, such as Bordeaux mixture, can be applied preventively to protect plants from bacterial infection. However, their efficacy may vary depending on the severity of the disease and environmental conditions.'),
                          Text('- Bactericides: Some bactericides, like streptomycin, may be effective in controlling angular leaf spot. However, their use should be judicious to prevent the development of bacterial resistance.'),
                          SizedBox(height: 16.0),
                          Text(
                            'Resistant Varieties:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('- Planting resistant varieties is one of the most effective methods to manage angular leaf spot. Breeding programs have developed bean cultivars with genetic resistance to the disease. Consult with local agricultural extension services or seed suppliers for information on resistant varieties suitable for your region.'),
                          SizedBox(height: 16.0),
                          Text(
                            'Biological Control:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('- Biological control agents, such as certain strains of beneficial bacteria and fungi, can help suppress the population of Pseudomonas syringae pv. phaseolicola. However, their effectiveness may vary, and more research is needed to optimize their use in managing angular leaf spot.'),
                          SizedBox(height: 16.0),
                          Text(
                            'Integrated Pest Management (IPM):',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('- Implementing an integrated pest management approach that combines cultural, chemical, and biological control methods tailored to the specific conditions of your farm can help effectively manage angular leaf spot while minimizing environmental impact and production costs.'),
                        ],
                      ),
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
      
      
      floatingActionButton: IconButton(onPressed: (){
        pickImage();
      }, icon: Image.asset("assets/images/camera.png", color: AppColors.primary_color, scale: 9,)),
    );
  }
}
