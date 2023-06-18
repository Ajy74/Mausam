import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_guru/res/theme/colors.dart';
// import 'dart:math' as math;
import '../../controller/splash_controller.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  SplashController _controller = Get.put(SplashController());

  // late final AnimationController _acontroller = AnimationController(
  //   duration: const Duration(seconds: 3),
  //   vsync: this
  //   )..repeat();

  @override
  void dispose() {
    _controller;
    // _acontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  // child:
                  // AnimatedBuilder(
                  //   animation: _acontroller, 
                  //   child: Container(
                      child: Center(
                        child: Image.asset("assets/images/no_internet.png",height: 200,width: 200,color: deepPurple,),
                      ),
                    ),
              //       builder: (BuildContext context,Widget? child){
              //         return  Transform.rotate(
              //           angle:_acontroller.value*2.0 * math.pi,
              //           child: child, 
              //         );
              //       }
              //     ),
                  
              //   ),

              ],
            ),
          ),
        ) 
      ),
    );
  }
}