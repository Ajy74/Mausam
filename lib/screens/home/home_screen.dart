
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_guru/controller/home_controller.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/screens/widgets/custom_app_bar.dart';
import 'package:weather_guru/screens/widgets/forConditions.dart';
import 'package:weather_guru/screens/widgets/foreCast_card.dart';
import 'package:weather_guru/utilities/app_constants.dart';
import '../../controller/advertisement/adController.dart';
import '../../utilities/text_styles.dart';
import '../widgets/gradient_text.dart';


import '../widgets/slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  // late final AnimationController _controller = AnimationController(
  // duration: const Duration(seconds: 5),
  // vsync: this
  // )..repeat();
  AdControlller adControlller = Get.put(AdControlller());
  HomeController homeController = Get.put(HomeController());
  var localTime = DateFormat.MMMMEEEEd().format(DateTime.now()); //Monday,11 june
  late var pressure ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adControlller.initBannerAd();
    // adControlller.initInterstitialAd();
  }

 
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child:RefreshIndicator(
            color: deepPurple,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onRefresh: () async{ 
              homeController.isDataLoaded.value = false ;
              await  homeController.getCoardinate() ;
             },
            child: Obx(() {
                  
              return 
              homeController.isDataLoaded.value == true ?
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: sidePadding18,vertical: sidePadding12),
                      child: CustomAppBar(
                        
                          leftChild:Row(
                              children: [
                                Image(image: AssetImage("assets/images/pin.png"),height: 30,width: 30,color: lightPurple,),
                                SizedBox(width: sizeBox5,),
                                // Obx(() => )
                                SizedBox(
                                  child: Text(
                                    "${homeController.weatherData.location!.name}",
                                    // "${homeController.subLocality.value}",
                                    style: titleStyle20,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ) ,
                          // rightChild: CircleAvatar(radius: 35,backgroundColor:Colors.transparent,child: Icon(Icons.person_pin,color:  brownshade.withOpacity(.5),size: 50,),),
                          rightChild: GestureDetector(
                            onTap: () {
                             Get.toNamed("/search_screen");
                            },
                            child: Icon(
                                Icons.search_rounded,
                                size: 45,color: brownshade.withOpacity(.5),
                              ),
                          ),
                        ),
                    ),
                  ), 
                      
                    SizedBox(height: sizeBox12,),
          
                   //for alerts 
                  //  CarouselWidget(),
          
                    SizedBox(height: sizeBox12,),
                      
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: sidePadding20),
                      child: Stack(
                        children: [
                          
                          Container(
                            width: Get.width,
                            // height: Get.height*0.30,
                            height: 230,
                          
                            child: Padding(
                              // padding: EdgeInsets.only(top:(Get.height*0.30 -Get.height*0.27) ),
                              padding: EdgeInsets.only(top:(Get.height*0.30 -Get.height*0.27) ),
                              child: Container(
                                width: Get.width,
                                // height: Get.height*0.28,
                                height: 215,
                                decoration: BoxDecoration(
                                  gradient: mainGredient,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(5, 8),
                                      blurRadius: 10,
                                      color: lightPurple.withOpacity(.7),
                                    ),
                                  ]
                                ),
                                child: Stack(
                                  children: [
                                              
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      clipBehavior: Clip.hardEdge,
                                      child: Container(color: Colors.white.withOpacity(.1),),
                                    ),
                      
                                    Column(
                                      children: [
                                      Expanded(child: cardTopRightSection(),),
                                      Expanded( child:cardBottomLeftSection(),),
                                      ],
                                    ),
                      
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      clipBehavior: Clip.hardEdge,
                                      child: Container(color: Colors.white.withOpacity(.2),),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                      
                          Positioned(
                              top: 0,
                              left: 5,
                              child: Image.asset(
                                homeController.currentIcon.value,
                                height: 120,
                                width: 200,
                              ),
                          ),
                      
                        ],
                      ),
                    ),
                      
                    SizedBox(height: 40,),
          
                     Container(
                      alignment: Alignment.center,width: double.maxFinite , height: 210,
                      child: SliderWidget(
                        sunrise: "${homeController.weatherData.forecast!.forecastday![0].astro!.sunrise}" , 
                        sunset: "${homeController.weatherData.forecast!.forecastday![0].astro!.sunset}",
                      )
                     ),
                      
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: sidePadding20),
                      child: Container(
                        width: Get.width,
                        // height: Get.height*0.23,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.9),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: lightPurple.withOpacity(.1),
                            ),
                          ]
                        ),
                        child: todayConditionSection(),
                      ),
                    ),
              
                    Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: sidePadding18,vertical: sidePadding20),
                        child: Row(
                          children: [
                            SizedBox(width: sizeBox5,),
                            Text("Hourly forecast",style: titleStyle22black,),
                            Expanded(child: Container()),
                            TextButton(
                              onPressed: () {
                                // adControlller.loadInterestitialAd();
                                adControlller.isNextPageReady.value = false;
                                adControlller.loadRewardAd("/forcast_day_screen");
                              }, 
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    // Customize the overlay color when the button is pressed
                                    if (states.contains(MaterialState.pressed)) {
                                      return deepPurple.withOpacity(.1);  // Replace with your desired color
                                    }
                                    return deepPurple.withOpacity(.1);  // Return null to use the default overlay color
                                  },
                                ),
                               
                              ),
                              child: Obx(() {
                                return   adControlller.isNextPageReady.value == true ?
                                Row(
                                  children: [
                                    Text("Next ${(homeController.weatherData.forecast!.forecastday!.length)-1} days",style: titleStyle16.copyWith(color: deepPurple),),
                                    Icon(Icons.arrow_forward_ios_rounded,size: 14,color: deepPurple,)
                                  ],
                                )
                                :Container(height: 20,width: 20,child: CircularProgressIndicator(color: deepPurple,strokeWidth:3 ,)) ;
                              })
                            ),
                          ],
                        ),
                      ),
                    ),
              
              
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        height: 220,
                        child: Center(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount:homeController.weatherData.forecast!.forecastday![0].hour!.length ,
                            itemBuilder: (BuildContext context, index ){
                            return  Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                               child: ForecastCard(
                                title1: ( DateFormat('E').format(DateTime.now()) ).toString(), 
                                title2: hrs12Formate("${homeController.weatherData.forecast!.forecastday![0].hour![index].time}") , 
                                iconPath: findIconPath(
                                  (homeController.weatherData.forecast!.forecastday![0].hour![index].condition!.text).toString().toLowerCase(), 
                                  (homeController.weatherData.forecast!.forecastday![0].hour![index].isDay)!.toInt()
                                ).toString(), 
                                temp: "${homeController.weatherData.forecast!.forecastday![0].hour![index].tempC}", 
                                isCurrent: checkTime(
                                    hrs12Formate("${homeController.weatherData.forecast!.forecastday![0].hour![index].time}")
                                  ) ? false : true
                               ),
                            ) ;
                          }
                          ),
                        ),
                      ),
                    ),
              
                    SizedBox(height: sizeBox20,),
                ],
              )
              : homeShimmer();
              
            },),
          )

      ),

      bottomNavigationBar: Obx(() {
        return  adControlller.isAdLoaded.value == true ? SizedBox(
          height: adControlller.bannerAd.size.height.toDouble(),
          width: adControlller.bannerAd.size.width.toDouble(),
          child: AdWidget(ad: adControlller.bannerAd),
        )  :SizedBox()  ;
      }) ,
    );
  }


  todayConditionSection(){
  return   
     Column(
      children: [
          Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(left: sidePadding18,right: sidePadding18,top: 8,bottom: 5),
              child: CustomAppBar(
                leftChild:  Row(
                  children: [
                    // SvgPicture.asset('assets/images/rotating_sun.svg',height: 35,width: 30, ),
                    SizedBox(width:sizeBox5 ,),
                    Text("Today's Condition",style: titleStyle22black,)
                  ],
                ),
                // rightChild: Icon(
                //   Icons.refresh,
                //   size: 30,color: deepPurple,
                // ),
              ),
            ),
          ),
          
          Expanded(
            child:Row(
              mainAxisAlignment: Get.mediaQuery.orientation == Orientation.portrait ? MainAxisAlignment.center :MainAxisAlignment.spaceEvenly,
              children: [
                ConditionItem(
                icon:  Image(image: AssetImage("assets/images/uv.png"),),
                title: "uv index",
                subTitle: "${homeController.weatherData.current!.uv}",
                ),
                ConditionItem(
                  icon: Image(image: AssetImage("assets/images/wind.png"),),
                  title: "wind",
                  subTitle: "${homeController.weatherData.current!.windKph.toString().split('.').first}kph",
                ),
                ConditionItem(
                  icon: Image(image: AssetImage("assets/images/humidity.png"),),
                  title: "humidity",
                  subTitle: "${homeController.weatherData.current!.humidity}%",
                ),
              
              ],
            )
          ),
          SizedBox(height: sizeBox5,),
          Expanded(
            child:Row(
              mainAxisAlignment: Get.mediaQuery.orientation == Orientation.portrait ? MainAxisAlignment.center :MainAxisAlignment.spaceEvenly,
              children: [
                ConditionItem(
                  icon: Image(image: AssetImage("assets/images/rain.png"),),
                  title: "rain         ",
                  subTitle: "${homeController.weatherData.forecast!.forecastday![0].day!.dailyChanceOfRain}%",
                ),
                ConditionItem(
                  icon: Image(image: AssetImage("assets/images/visibility.png"),),
                  title: "visible",
                  subTitle: "${homeController.weatherData.current!.visKm} km",
                ),
                ConditionItem(
                  icon: Image(image: AssetImage("assets/images/pressure.png"),),
                  title: "pressure",
                  subTitle: "${(homeController.weatherData.current!.pressureMb! * 0.000986923).toStringAsFixed(2)} atm",
                ),
              
              ],
            )
          ),
          
          SizedBox(height: sizeBox12,),
     
        ],
      )

       ;
    }

  cardTopRightSection(){
  return  
      Row(
          children: [
            SizedBox(width:Get.width*.560 ,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                Stack(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2,right: 4),
                            child: GradientText(
                              '${homeController.weatherData.current!.tempC.toString().split('.').first}',
                              style: tempeartureText,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                Colors.white,
                                Colors.white.withOpacity(.9),
                                deepBlue,
                              ]),
                            ),
                          ),
                        SizedBox(width: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: CustomPaint(
                              size: Size(11, 11),
                              painter: CircleIconPainter(
                                strokeGradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [  
                                    Colors.white,
                                    Colors.white.withOpacity(.4),
                                    Colors.white.withOpacity(.4),
                                  ], // Set your desired gradient colors
                                ),
                                strokeWidth: 3.0, // Set your desired stroke width
                              ),
                          )
                        ),
                        SizedBox(width: sizeBox5,),
                          // SizedBox(width: 30,)
                        ],
                      ),
                      Positioned(
                        bottom: 1,
                        left: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 4,),
                            Text("Feels Like",style: titleStyle10,),
                            SizedBox(width:sizeBox5),
                            Text("${homeController.weatherData.current!.feelslikeC.toString().split('.').first}",style: titleStyle10),
                            SizedBox(width:3),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: CustomPaint(
                                  size: Size(3, 3),
                                  painter: CircleIconPainter(
                                    strokeGradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [  
                                        Colors.white.withOpacity(.6),
                                        Colors.white.withOpacity(.6),
                                      ], // Set your desired gradient colors
                                    ),
                                    strokeWidth: 1.2, // Set your desired stroke width
                                  ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                )
              ],
            ),
            SizedBox(width:15,),
          ],
        )
  ;
}

  cardBottomLeftSection(){
  return 
    Row(
        children: [
          Expanded(
            child: Stack(
              children: [

                 Positioned(
                    top: 12,
                    right: 28,
                    child: Row(
                      children: [
                        Image(image: AssetImage("assets/images/hail.png"),height: 60,width: 50,color: Colors.white.withOpacity(.08),),
                        Image(image: AssetImage("assets/images/doted.png"),height: 20,color: Colors.white.withOpacity(.1),),
                      ],
                    ),
                 ),
                 Positioned(
                    bottom: 4,
                    right: 130,
                    child: Row(
                      children: [
                        Image(image: AssetImage("assets/images/doted.png"),height: 20,color: Colors.white.withOpacity(.2),),
                      ],
                    ),
                 ),
                 Positioned(
                    bottom: 4,
                    right: 90,
                    child: Row(
                      children: [
                        Image(image: AssetImage("assets/images/doted.png"),height: 20,color: Colors.white.withOpacity(.1),),
                      ],
                    ),
                 ),
                 Positioned(
                    bottom: 22,
                    right: 110,
                    child: Row(
                      children: [
                        Image(image: AssetImage("assets/images/doted.png"),height: 20,color: Colors.white.withOpacity(.1),),
                      ],
                    ),
                 ),
                 Positioned(
                    bottom: 18,
                    right: 60,
                    child: Row(
                      children: [
                        Image(image: AssetImage("assets/images/doted.png"),height: 20,color: Colors.white.withOpacity(.1),),
                      ],
                    ),
                 ),

                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25,top:10,right: 18),
                      child: Text(
                        "${homeController.weatherData.current!.condition!.text}",style: titleStyle22.copyWith(fontSize: 20.2),
                        overflow:TextOverflow.ellipsis ,
                        maxLines: 2,
                      ),
                      // child: Text("Modification",style: titleStyle22,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,top: 5,right: 6,bottom: 12),
                      child: Text("${localTime}",style: titleStyle16.copyWith(fontSize: 14),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
    )
  ;
}

  homeShimmer(){
     return Shimmer.fromColors( 
        baseColor: Colors.grey.withOpacity(.3), 
        highlightColor: Colors.white.withOpacity(.8),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
            children: [
                  Container(height: 45,width: Get.width,color: Colors.grey,),
                  SizedBox(height: 30,),
                  Container(height: 200,width: Get.width,color: Colors.grey,),
                  SizedBox(height: 20,),
                  Container(height: 180,width: Get.width,color: Colors.grey,),
                  SizedBox(height: 20,),
                  Container(height: 20,width: Get.width,color: Colors.grey,),
                  SizedBox(height: 20,),
                  Container(
                    height: 180,
                    child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return  Padding(
                        padding: const EdgeInsets.only(top:12.0,left: 6,bottom: 12,right: 6),
                        child: Container(height: 120,width: 100,color: Colors.grey,),
                      ) ;
                  }),
                  )
            ],
          ),
        ),
      );
  }


  

  String convertTo24HourFormat(String time12h) {
    final DateFormat format12h = DateFormat('h:mm a');
    final DateFormat format24h = DateFormat('HH.m');

    final DateTime dateTime12h = format12h.parse(time12h);
    final String time24h = format24h.format(dateTime12h);

    return time24h;
  }



}



class CircleIconPainter extends CustomPainter {
  final Gradient strokeGradient;
  final double strokeWidth;

  CircleIconPainter({
    required this.strokeGradient,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = strokeGradient.createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ));

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CircleIconPainter oldDelegate) {
    return oldDelegate.strokeGradient != strokeGradient ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}


