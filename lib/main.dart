import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:weather_guru/res/routes/routes.dart';
import 'package:weather_guru/res/theme/app_theme.dart';
import 'package:weather_guru/res/theme/colors.dart';

import 'Db/db_helper.dart';


void main() async {
  // var devices = ["FADD999B4931F7FEBA4257185DE5CA4B"];
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await DBHelper.initDb();
  await GetStorage.init();
  
  // RequestConfiguration requestConfiguration = RequestConfiguration(
  //   testDeviceIds: devices
  // );
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final quickActions = QuickActions();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(GetPlatform.isMobile){

       quickActions.setShortcutItems(([
      // ShortcutItem(type: 'forcast', localizedTitle: 'Check Forcast'),
      ShortcutItem(type: 'search', localizedTitle: 'Search',icon: 'search'),
      ShortcutItem(type: 'map', localizedTitle: 'Weather Map',icon: 'cloud'),
    ]));
    quickActions.initialize((type) {
      
      // if(type == 'forcast'){
      //   Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context)=> ForcastDayScreen() ),
      //   );
      // }
      if(type == 'map'){
       Fluttertoast.showToast(
          msg: "Comming Soon !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: lightPurple,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
      if(type == 'search'){
       Fluttertoast.showToast(
          msg: "Comming Soon !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: lightPurple,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }

     });

    }

  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mausam',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
    );
  }
}

