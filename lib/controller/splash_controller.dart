import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restart_app/restart_app.dart';

import '../res/theme/colors.dart';
import '../services/internet_connection_service.dart';

class SplashController extends GetxController{

  InternetServices _internetServices = Get.put(InternetServices());
  final isInternetConnected = false.obs;

@override
  void onReady() {
    super.onReady();
     navigateToHome();
  }

  void navigateToHome() async{
    // await Future.delayed(Duration(seconds: 3));
    isInternetConnected.value = await _internetServices.execute(InternetConnectionChecker());
     if(isInternetConnected.value == true){
        Get.offAllNamed("/home_screen");
     }
     else{
      Fluttertoast.showToast(
          msg: "please check internet connection !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: lightPurple,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Restart.restartApp();
     }
    
  }

}