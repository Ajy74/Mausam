import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/searchController.dart';

import '../../res/theme/colors.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/text_styles.dart';
import '../widgets/condition_card.dart';
import '../widgets/foreCast_card.dart';
import '../widgets/futureListStyle.dart';

class SearchDetailScreen extends StatefulWidget {
  const SearchDetailScreen({super.key});

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> with TickerProviderStateMixin {

  LocationSearchController locationSearchController = Get.put(LocationSearchController());
 
  // late final AnimationController _animController = AnimationController(
  //   duration: const Duration(seconds: 3),
  //   vsync: this
  // )..repeat();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // adControlller.initBannerAd();
  }

  @override
  void dispose() {
    // _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
     final city = arguments["city"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text("${city}",style: titleStyle22.copyWith(color: deepPurple),),
        foregroundColor: deepPurple,
      ),

      body: //Obx(() {
        // return locationSearchController.isFavCityDataLoaded.value == true ? 

          Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: deepPurple),
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:17.0),
                        child: Hero(
                          tag: Key('favCity'),
                          child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                       locationSearchController.weatherData.current!.condition!.text.toString(),
                                       style: titleStyle20.copyWith(color: deepBlue),
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                      ),
                                    ) ,
                                    FutureListStyle(
                                      iconPath:locationSearchController.currentIcon.value,
                                      temp:locationSearchController.weatherData.current!.tempC.toString().split(".").first,
                                      title:DateFormat.EEEE().format(DateTime.parse(
                                                (locationSearchController.weatherData.forecast!.forecastday![0].date).toString() )) ,
                                      subTitle:DateFormat('d MMM, yy').format(DateTime.parse( (locationSearchController.weatherData.forecast!.forecastday![0].date).toString() ))
                                    ),
                                  ]
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ConditionCardWidget(
                                iconPath: 'assets/images/uv.png',
                                title: 'UV index',
                                value: '${locationSearchController.weatherData.current!.uv}',
                              ),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              child: ConditionCardWidget(
                                iconPath: 'assets/images/wind.png',
                                title: 'Wind',
                                value: '${locationSearchController.weatherData.current!.windKph.toString().split('.').first} kph',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: ConditionCardWidget(
                                iconPath: 'assets/images/humidity.png',
                                title: 'Humidity',
                                value: '${locationSearchController.weatherData.current!.humidity}%',
                              ),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              child: ConditionCardWidget(
                                iconPath: 'assets/images/rain.png',
                                title: 'Rain possible',
                                value: '${locationSearchController.weatherData.forecast!.forecastday![0].day!.dailyChanceOfRain}%',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: ConditionCardWidget(
                                iconPath: 'assets/images/visibility.png',
                                title: 'Visibility',
                                value: '${locationSearchController.weatherData.current!.visKm} km',
                              ),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              child: ConditionCardWidget(
                                iconPath: 'assets/images/pressure.png',
                                title: 'Pressure',
                                value: '${(locationSearchController.weatherData.current!.pressureMb! * 0.000986923).toStringAsFixed(2)} atm',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                 SizedBox(height: 12,),

                 Padding(
                   padding: const EdgeInsets.only(left: 20,right: 20),
                   child: Text("Hourly forecast",style: titleStyle22black,),
                 ),

                 SizedBox(height: 20,),

                  Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 220,
                            child: Center(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:locationSearchController.weatherData.forecast!.forecastday![0].hour!.length ,
                                itemBuilder: (BuildContext context, index ){
                                return  Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                   child: ForecastCard(
                                    title1: ( DateFormat('E').format(DateTime.now()) ).toString(), 
                                    title2: hrs12Formate("${locationSearchController.weatherData.forecast!.forecastday![0].hour![index].time}") , 
                                    iconPath: findIconPath(
                                      (locationSearchController.weatherData.forecast!.forecastday![0].hour![index].condition!.text).toString().toLowerCase(), 
                                      (locationSearchController.weatherData.forecast!.forecastday![0].hour![index].isDay)!.toInt()
                                    ).toString(),
                                    temp: "${locationSearchController.weatherData.forecast!.forecastday![0].hour![index].tempC}", 
                                    isCurrent:  checkTime(
                                        hrs12Formate("${locationSearchController.weatherData.forecast!.forecastday![0].hour![index].time}")
                                      ) ? false : true
                                   ),
                                ) ;
                              }
                              ),
                            ),
                          ),
                        ),

                ],
              ),
          )

        // : Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //         SpinKitWave(
        //           color: deepPurple,
        //           size: 60.0,
        //           controller: _animController,
        //         ),
        //     ],
          // );
      // }) ,
    );
  }
  
  
}