import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';


class ConnectivityService extends GetxService {
  RxBool isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      checkConnectivity();
    });
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isOnline.value = false;
    } else {
      isOnline.value = true;
    }
  }
}
