import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_guru/res/theme/colors.dart';

class InternetServices extends GetxService{


  Future<bool> execute(InternetConnectionChecker internetConnectionChecker) async {
    // Simple check to see if we have Internet
   
    var isConnected = await InternetConnectionChecker().hasConnection;
    // ignore: avoid_print
    print(
      isConnected.toString(),
    );

    if(isConnected){
        //move to the no connection page
        return isConnected;
    }
    else{
      Get.snackbar(
        "Check your internet !", 
        "not connected to internet",
        backgroundColor: lightPurple.withOpacity(.3),
        icon: const Icon(Icons.network_check_outlined,color: deepPurple),
      );
    }
    // returns a bool

    // actively listen for status updates
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (kDebugMode) {
              print('Data connection is available.');
            }
            isConnected = true;
            break;
          case InternetConnectionStatus.disconnected:
            if (kDebugMode) {
              print('You are disconnected from the internet.');
            }
            isConnected = false;
            break;
        }
      },
    );

    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 10));
    await listener.cancel();
    // if(isConnected == false){
    //   Restart.restartApp();
    // }
    return isConnected;
  }
}
