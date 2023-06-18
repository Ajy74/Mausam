
import 'package:flutter/material.dart';
import 'package:weather_guru/res/theme/colors.dart';

class AppTheme{

 static final light = ThemeData(
    // colorScheme: ColorScheme(
    //   brightness: Brightness.light,
    //   primary: AppColor.creamColor,
    //   onPrimary: Colors.black,

    //   secondary: AppColor.bluishClr,
    //   onSecondary: AppColor.bluishClr,
    //   surface:  AppColor.bluishClr,
    //   onSurface:  AppColor.darkGreyClr,
    //   error: AppColor.darkGreyClr,
    //   onError: Colors.white,
    //   background:AppColor.creamColor,
    //   onBackground: AppColor.creamColor,
    // ),
      primaryColor: deepPurple ,
      brightness: Brightness.light,
      canvasColor: Color.fromARGB(255, 254, 244, 255), 
      
  );

  static final dark = ThemeData(
    // colorScheme:  ColorScheme(
    //   brightness: Brightness.dark,
    //   surface:AppColor.darkCreamColor ,
    //   onSurface: Colors.white,

    //   primary: AppColor.darkGreyClr,
    //   onPrimary: AppColor.darkGreyClr,
    //   secondary: AppColor.darkGreyClr,
    //   onSecondary: AppColor.darkGreyClr,
    //   error: AppColor.darkGreyClr,
    //   onError:AppColor.darkGreyClr,
    //   background:AppColor.darkCreamColor,
    //   onBackground:AppColor.darkCreamColor,
    // ),
      primaryColor: deepPurple ,
      brightness: Brightness.light,
      canvasColor: purpleShade.withOpacity(.3),  
  );

}