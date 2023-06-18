import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../res/theme/colors.dart';

const double sidePadding12 = 12.0;
const double sidePadding18 = 18.0;
const double sidePadding20 = 20.0;

double mobileHeight = Get.height;
double mobileWidth = Get.width;

const double cardRadius16 = 16.0;
const double cardRadius40 = 40.0;

const double sizeBox12 =12.0;
const double sizeBox20 =20.0;
const double sizeBox5 =5.0;

const double text35 = 35.0;
const double text25 = 25.0;
const double text18 = 18.0;
const double text15 = 15.0;
const double text14 = 14.0;
const double text13 = 13.0;
const double text12 = 12.0;

const String sunny ="assets/images/sunny.png";
const String clear ="assets/images/clear_night.png";
const String cloudy ="assets/images/cloudy.png";
const String partly_cloudy ="assets/images/partly_cloud.png";
const String partly_cloudy_night ="assets/images/partly_cloud_night.png";
const String cloudyNight ="assets/images/cloudy_night.png";
const String mist ="assets/images/cloudy.png";
const String fog ="assets/images/heavycloud.png";
const String lightRain ="assets/images/patchy_rain.png";
const String lightRainNight ="assets/images/night_light_rain.png";
const String lightSleet ="assets/images/sleet.png";
const String heavyRain ="assets/images/lightrain.png";
const String snow ="assets/images/hail.png";
const String snowRain ="assets/images/sleet.png";
const String lightThunder ="assets/images/thunder.png";
const String lightThunderNight ="assets/images/thunderstorm.png";
const String thunderRain ="assets/images/thunder_rain_night.png";


const double kDiameter = 200;
// const double kMinDegree = 16;
// const double kMaxDegree = 28;

double  degToRad(num deg) => deg * (pi / 180.0);
double normalize(value, min, max) => ((value - min) / (max - min));

 lineBar(){
    return  Padding(
      padding: const EdgeInsets.only(left: 5,right: 5),
      child: Container(width: Get.width,height: 2,color: deepPurple.withOpacity(.1),),
    );
  }

  String hrs12Formate(String date_time) {
    String timestamp = date_time;

    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    // print(formattedTime); // Output: 10:00 PM
    return formattedTime;
  }

  bool checkTime(String indexTime ){
    String current = hrs12Formate(DateTime.now().toString());
    String c1 = current.split(':').first;
    String c2 = current.split(':').last.split(" ").last;

    String i1 = indexTime.split(':').first;
    String i2 = indexTime.split(':').last.split(" ").last;
    // print("c1--$c1");
    // print("i1--$i1");
    // print("c2--$c2");
    // print("i2--$i2");
    
    if(c1 == i1 && c2 == i2){
      return true;
    }
    return false ;
  }

  String findIconPath(String condition,int day){
    String con = condition.toLowerCase();
    // print("..%%%%%%$con");

    if(day==1){
      if(con == 'sunny'){
        return sunny;
      }

      if(con == 'overcast' ){
        return cloudy;
      }
      if(con == 'cloudy' ){
        return cloudy;
      }
      if(con == 'partly cloudy' ){
        return partly_cloudy;
      }
      if(con == 'mist'){
        return mist;
      }
      if(con == 'fog' || con =='freezing fog'){
       return fog;
      }
      if(con=='patchy rain possible' ||con == 'patchy rain nearby' || con == 'patchy freezing drizzle nearby'  || con=='patchy light rain' || con == 'light rain' || con == 'light rain shower'){
        return lightRain;
      }
      if(con == 'patchy snow nearby'  || con == 'patchy sleet nearby'  || con == 'blowing snow'  || con == 'blizzard'){
        return snowRain;
      }
      if(con == 'patchy light dizzle'  || con == 'light dizzle'  || con == 'freezing dizzle' ||  con == 'moderate rain at times' || con == 'moderate rain'|| con=='heavy rain at times' || con =='heavy rain' || con == 'light freezing rain' || con=='moderate or heavy freezing rain' || con=='moderate or heavy rain shower' || con == 'torrential rain shower' ){
        return heavyRain;
      }
      if(con == 'light sleet' || con == 'moderate or heavy sleet' || con == 'patchy light snow' || con =='light snow' || con == 'patchy moderate snow' || con == 'moderate snow' || con == 'patchy heavy snow' || con == 'heavy snow' || con == 'ice pellets' || con == 'light sleet showers' || con == 'moderate or heavy sleet showers'  ){
        return lightSleet;
      }
      
       if(con == 'moderate or heavy snow showers' || con=='light showers of ice pellets' || con=='moderate or heavy showers of ice pellets' ){
        return snow;
      }

      if(con=='patchy light rain in area with thunder' || con == 'moderate or heavy rain in area with thunder' || con =='Moderate or heavy snow in area with thunder' || con == 'thundery outbreaks possible' ){
        return thunderRain;
      }
      
      if(con=='Patchy light snow in area with thunder'  ){
        return lightThunder;
      }

      

    }
    else{
      if(con == 'clear'){
        return clear;
      }
      if(con == 'overcast' ){
        return cloudy;
      }
      if(con == 'cloudy' ){
        return cloudyNight;
      }
      if(con == 'partly cloudy'){
        return partly_cloudy_night;
      }
      if(con == 'mist'){
        return mist;
      }
      if(con == 'fog' || con =='freezing fog'){
       return fog;
      }
      if(con=='patchy rain possible' || con == 'patchy rain nearby' || con == 'patchy freezing drizzle nearby' || con=='patchy light rain' || con =='light rain' || con == 'light rain shower'){
        return lightRainNight;
      }
      if(con == 'patchy snow nearby'  || con == 'patchy sleet nearby'  || con == 'blowing snow'  || con == 'blizzard'){
        return snowRain;
      }
      if(con == 'patchy light dizzle'  || con == 'light dizzle'  || con == 'freezing dizzle' ||  con == 'moderate rain at times' || con == 'moderate rain' || con=='heavy rain at times' || con =='heavy rain' || con == 'light freezing rain' || con=='moderate or heavy freezing rain' || con=='moderate or heavy rain shower' || con == 'torrential rain shower' ){
        return heavyRain;
      }

      if(con == 'light sleet' || con == 'moderate or heavy sleet' || con == 'patchy light snow' || con =='light snow' || con == 'patchy moderate snow' || con == 'moderate snow' || con == 'patchy heavy snow' || con == 'heavy snow' || con == 'ice pellets' || con == 'light sleet showers' || con == 'moderate or heavy sleet showers' ){
        return lightSleet;
      }

      if(con == 'moderate or heavy snow showers' || con=='light showers of ice pellets' || con=='moderate or heavy showers of ice pellets' ){
        return snow;
      }

      if(con=='patchy light rain in area with thunder' || con == 'moderate or heavy rain in area with thunder' || con =='Moderate or heavy snow in area with thunder' || con == 'thundery outbreaks possible'){
        return thunderRain;
      }
      
      if(con=='Patchy light snow in area with thunder'  ){
        return lightThunderNight;
      }
      

    }

    return '';
  }