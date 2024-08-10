import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:weather_guru/models/forcast_weather_model.dart';
import 'package:weather_guru/services/api_end_points.dart';

import '../res/theme/colors.dart';

class Forcast{

  String lat;
  String long;
  Forcast({required this.lat,required this.long});

  // late dynamic data;

  Future<ForCastModel> fetchForcast() async{
    dynamic data;
    final response = await http.get(Uri.parse("${ApiEndPoints.forcastWeatherUrl}&q=${lat},${long}&days=7&aqi=no&alerts=yes"));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
      // print(data);
    }
    else{
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      //move to the something wrong page;
       Fluttertoast.showToast(
          msg: "Something went wrong !\nwi'll come back soon !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: lightPurple,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    return ForCastModel.fromJson(data);
  }


}