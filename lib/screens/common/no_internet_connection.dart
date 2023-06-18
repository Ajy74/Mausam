import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'dart:math' as math;

import '../../services/internet_connection_service.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> with TickerProviderStateMixin{

    InternetServices internetServices = Get.put(InternetServices());

    late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this
    )..repeat();
     
    bool isClicked = false;

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
    internetServices;
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
                Image(
                  image: AssetImage("assets/images/no_internet.png"),
                  color: deepPurple,
                ),

                SizedBox(height: 50,),

                InkWell(
                  onTap: () {
                    isClicked=true;  
                    setState(() {
                      // print("$isClicked");
                    });
                    checkInternet();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: deepPurple.withOpacity(.3))
                    ),
                    child:
                    isClicked ==false ?
                     Container(
                      width: 50,
                      height: 50,
                      child:Icon(Icons.refresh_rounded,size: 50,color: deepPurple,) ,
                    )
                    :
                    AnimatedBuilder(
                      animation: _controller, 
                      child: Container(
                        height: 50,
                        width: 50,
                        child: const Center(
                          child: Icon(Icons.refresh_rounded,size: 50,color: deepPurple,),
                        ),
                      ),
                      builder: (BuildContext context,Widget? child){
                        return  Transform.rotate(
                          angle:_controller.value*3.0 * math.pi,
                          child: child, 
                        );
                      }
                    ),
                    
                  ),
                ),

              ],
            ),
          ),
        ) 
      ),
    );
  }
  
  void checkInternet() async {
    final _isConnected = await internetServices.execute(InternetConnectionChecker());
    if(_isConnected){
      _controller.dispose();
      Get.offAllNamed("/home_screen");
    }
    else{
      // _controller.stop();  
      _controller.clearListeners();   
      isClicked = false;
      setState(() {
       _controller.repeat(period: Duration(seconds: 5));
      });
    }

  }

}