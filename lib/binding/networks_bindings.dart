import 'package:agriconnectfinal/controller/networkcontroller.dart';
import 'package:get/get.dart';


class NetworkBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
  }

}