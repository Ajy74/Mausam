import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:weather_guru/controller/advertisement/adController.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/screens/widgets/futureListStyle.dart';
import 'package:weather_guru/utilities/text_styles.dart';

import '../../controller/forcast_day_controller.dart';
import '../../controller/home_controller.dart';
import '../../utilities/app_constants.dart';
import '../widgets/foreCast_card.dart';
import '../widgets/gradient_text.dart';

class ForcastDayScreen extends StatefulWidget {
  const ForcastDayScreen({super.key});

  @override
  State<ForcastDayScreen> createState() => _ForcastDayScreenState();
}

class _ForcastDayScreenState extends State<ForcastDayScreen> with TickerProviderStateMixin {

  AdControlller adControlller = Get.put(AdControlller());
  HomeController _controller = Get.put(HomeController());
  ForCastDayController _forCastDayController = Get.put(ForCastDayController());

  late final AnimationController _animController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this
  )..repeat();
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adControlller.initBannerAd();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Future Weather",style: titleStyle22.copyWith(color: deepPurple),),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          foregroundColor: deepPurple,
        ),
        body: 
        Obx(() {
          return 
          _forCastDayController.loader.value == false && _controller.isDataLoaded.value == true
          ?
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.transparent,
              showLeading: false,
              showTrailing: false,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator(); // Disables the overscroll glow effect
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                
                        SizedBox(height: 8,),
                
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: _controller.weatherData.forecast!.forecastday!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, index ){
                                return GestureDetector(
                                  onTap: () {
                                    adControlller.loadInterstitialAd_forSame();
                                    _forCastDayController.getDateIndex(index);
                                  }, 
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(() {
                                        return 
                                          _forCastDayController.dateIndex.value != index?
                                            Container(
                                              height: 35,
                                              width: 70,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: deepPurple),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              child:  GradientText(
                                                        DateFormat('d MMM').format(DateTime.parse( (_controller.weatherData.forecast!.forecastday![index].date).toString() )),
                        
                                                        style: titleStyle14,
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [
                                                          deepPurple,
                                                          deepPurple.withOpacity(.9),
                                                          deepBlue,
                                                        ]),
                                                      ),
                                            )
                                          :
                                            Container(
                                              height: 35,
                                              width: 70,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: deepPurple),
                                                borderRadius: BorderRadius.circular(14),
                                                gradient: mainGredient
                                              ),
                                              child:  GradientText(
                                                        DateFormat('d MMM').format(DateTime.parse( (_controller.weatherData.forecast!.forecastday![index].date).toString() )),
                        
                                                        style: titleStyle14,
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [
                                                          Colors.white,
                                                          Colors.white.withOpacity(.9),
                                                          Colors.white,
                                                        ]),
                                                      ),
                                            )
                                        ;
                                    } ),
                                  ) ,
                                );
                            }
                          ),
                        ),
                
                        SizedBox(height: 12,),
                
                        Obx(() {
                          return  Container(
                                height: 220,
                                child: Center(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:_controller.weatherData.forecast!.forecastday![_forCastDayController.dateIndex.value].hour!.length ,
                          
                                    itemBuilder: (BuildContext context, index ){
                                    return  Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: ForecastCard(
                                        title1: ( 
                                          DateFormat('E').format( DateTime.parse(
                                          ( _controller.weatherData.forecast!.forecastday![_forCastDayController.dateIndex.value].hour![index].time).toString() 
                                        )) )  , 
                      
                                        title2: hrs12Formate( (_controller.weatherData.forecast!.forecastday![_forCastDayController.dateIndex.value].hour![index].time).toString() ), 
                      
                                        iconPath: findIconPath(
                                          (_controller.weatherData.forecast!.forecastday![_forCastDayController.dateIndex.value].hour![index].condition!.text).toString().toLowerCase(), 
                                          (_controller.weatherData.forecast!.forecastday![_forCastDayController.dateIndex.value].hour![index].isDay)!.toInt()
                                        ).toString(), 
                      
                                        temp: "${_controller.weatherData.forecast!.forecastday![_forCastDayController.dateIndex.value].hour![index].tempC}", 
                                        isCurrent: false
                                      ) 
                                    );
                                  }
                                  ),
                                ),
                              );
                        }),
                
                         SizedBox(height: 30,),
                      
                        Container(
                          child: Stack(
                            clipBehavior: Clip.hardEdge,
                            children: [
                            Positioned(
                              top: 0,
                              left: 20,
                              right: 20,
                              child:  Container(
                                width: Get.width,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: deepPurple.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                            ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  width: Get.width,
                                  height: 290,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 8),
                                        blurRadius: 10,
                                        color: lightPurple.withOpacity(.1),
                                      ),
                                    ]
                                  ),
                                  child: daysList(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          )
          :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                SpinKitWave(
                  color: deepPurple,
                  size: 60.0,
                  controller: _animController,
                ),
            ],
          );
          // ;
        }),

        bottomNavigationBar: Obx(() {
          return  adControlller.isAdLoaded.value == true ? SizedBox(
            height: adControlller.bannerAd.size.height.toDouble(),
            width: adControlller.bannerAd.size.width.toDouble(),
            child: AdWidget(ad: adControlller.bannerAd),
          )  :SizedBox()  ;
        }) ,
    );
  }

  daysList() {
    return Padding(
      padding: const EdgeInsets.only(top:16.0,left: 20,right: 20,bottom: 16),
       child: 
              ListView.builder(
                clipBehavior: Clip.hardEdge,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: _controller.weatherData.forecast!.forecastday!.length,
                itemBuilder: (BuildContext context,index){
                  
                  return Column(
                    children: [
                     FutureListStyle(
                       iconPath:findIconPath(
                        (_controller.weatherData.forecast!.forecastday![index].day!.condition!.text).toString(), 1), 
              
                      temp:(_controller.weatherData.forecast!.forecastday![index].day!.avgtempC).toString().split('.').first, 
              
                      title:DateFormat.EEEE().format(DateTime.parse(
                        (_controller.weatherData.forecast!.forecastday![index].date).toString() )), 
              
                      subTitle:DateFormat('d MMM, yy').format(DateTime.parse( (_controller.weatherData.forecast!.forecastday![index].date).toString() )),
                     ),
                      index == (_controller.weatherData.forecast!.forecastday!.length)-1 ?Container():lineBar(),
                    ],
                  ) ;
              
              })
    ) ;
  }

  
  String hrs12Formate(String date_time) {
    String timestamp = date_time;

    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    // print(formattedTime); // Output: 10:00 PM
    return formattedTime;
  }
  
}