import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


import 'package:weather_guru/models/forcast_weather_model.dart';
import 'package:weather_guru/services/forcast_calling.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_guru/services/internet_connection_service.dart';
import 'package:weather_guru/services/location_service.dart';
import 'package:weather_guru/utilities/app_constants.dart';

import '../res/theme/colors.dart';

class HomeController extends GetxController{

  LocationService _locationService = Get.put(LocationService());
  InternetServices _internetServices = Get.put(InternetServices());

  dynamic coardinate = [].obs;
  final isDataLoaded = false.obs;
  final currentIcon = ''.obs;
  late ForCastModel weatherData ;
  final isInternetConnected = true.obs;  

  final locality = ''.obs;
  final subLocality = ''.obs;


  @override
  void onReady() {
    getCoardinate();
    // print("lll->>$isDataLoaded");
    super.onReady();
  }
  
  Future<void> getCoardinate() async{
    
    //check for gps first
    if(await _locationService.checkGps() == false){
      Fluttertoast.showToast(
          msg: "Check your GPS is enabled or not !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: lightPurple,
          textColor: Colors.white,
          fontSize: 16.0
      );
      exit(0);
      // return ;
    }

    //then cheking for internet 
    isInternetConnected.value = await _internetServices.execute(InternetConnectionChecker());
    if(isInternetConnected.value == false){
      //move to no internet connection page
      Get.offAllNamed("/no_internet_screen");
      return;
    }

    coardinate = await _locationService.getLocation();
    locality.value = _locationService.locality;
    subLocality.value = _locationService.subLocality;
    // print("${coardinate[0]}...and...${coardinate[1]}");
    
    //check for empty coardinates and move to request_permission_again page
    if(coardinate.length==0 || coardinate.length<1){
      Fluttertoast.showToast(
          msg: "enable location permission from settings!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: lightPurple,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Get.offAllNamed("/request_permision_again");
      return ;
    }
    //for fetching api data
    final obj = Forcast(lat: coardinate[0], long: coardinate[1]);
    weatherData  =  await obj.fetchForcast() ;
    // print(weatherData.current!.condition!.text);
    currentIcon.value  = findIconPath(
        (weatherData.current!.condition!.text).toString().toLowerCase(), 
       (weatherData.current!.isDay)!.toInt()
      );
    isDataLoaded.value =  true;
  }


}