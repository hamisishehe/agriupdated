import 'package:agriconnectfinal/contants/appcolors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NetworkController extends GetxController{
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _updateconnectionstatus;
    Connectivity().onConnectivityChanged.listen((result) {
      _updateconnectionstatus();
    });
  }



    void _updateconnectionstatus () async{
      var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: Text("PLEASE CONNECT TO THE INTERNET"),
        isDismissible: false,
        duration: Duration(days: 1),
        backgroundColor: AppColors.primary_color,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED
      );
    }
    else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }

  }
}