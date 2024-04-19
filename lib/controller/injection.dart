import 'package:agriconnectfinal/controller/networkcontroller.dart';
import 'package:get/get.dart';

class Injection {
  static void init(){
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}