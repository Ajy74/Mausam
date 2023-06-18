import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:weather_guru/models/fav_city_model.dart';

import '../../Db/db_helper.dart';

class StoreCityController extends GetxController{

  var cityList = <FavCityModel>[].obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   getCities();
  // }

  
Future<int> addCity({FavCityModel? city})async{
  return await DBHelper.insert(city) ;
}

//get all the data from table
dynamic getCities() async {
  List<Map<String,dynamic>> cities = await DBHelper.query();
  cityList.assignAll(cities.map((data) => FavCityModel.fromJson(data)).toList() );
  if (kDebugMode) {
    print("actual size-->${cityList.length}");
  }
}

void delete(FavCityModel city)async{
  var val = await DBHelper.delete(city);
  getCities();
  if (kDebugMode) {
    print(val);
  }
}

Future<void> cityUpdate(int citykId,double temp,String iconPath,String weekDay,String date,int isDay)async{
  var val = await DBHelper.upadte(citykId,temp,iconPath,weekDay,date,isDay);
  getCities();
  if (kDebugMode) {
    print(val);
  }
}

}