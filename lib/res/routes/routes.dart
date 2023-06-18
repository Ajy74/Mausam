import 'package:get/get.dart';
import 'package:weather_guru/screens/common/no_internet_connection.dart';
import 'package:weather_guru/screens/common/request_permission_again.dart';
import 'package:weather_guru/res/routes/route_name.dart';
import 'package:weather_guru/screens/home/home_screen.dart';
import 'package:weather_guru/screens/search/search.dart';

import '../../screens/forcast day/forcast_day_Screen.dart';
import '../../screens/search/search_detail.dart';
import '../../screens/splash/splash_screen.dart';

class AppRoutes{

  static appRoutes()=>[

    GetPage(
      name: RoutesName.splashScreen, 
      page: ()=> const SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: RoutesName.homeScreen, 
      page: ()=> const HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: RoutesName.requestPermissionAgain, 
      page: ()=> const RequestAgainPermisson(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: RoutesName.noInternetScreen, 
      page: ()=> const NoInternetScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: RoutesName.forcastDayScreen, 
      page: ()=> const ForcastDayScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: RoutesName.searchScreen, 
      page: ()=> const SearchScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: RoutesName.search_detail_Screen, 
      page: ()=> const SearchDetailScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

  ];

}