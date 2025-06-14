
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/utilities/text_styles.dart';

import '../../utilities/app_constants.dart';
import 'custom_draw.dart';

class SliderWidget extends StatefulWidget {

  const SliderWidget({super.key,required this.sunrise,required this.sunset});

  final String sunrise;
  final String sunset;
  
  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late double progressVal;
  late String sunrise;
  late String sunset;
  late double crnTime;

  @override
  void initState() {
    super.initState();
    sunrise = widget.sunrise;
    sunset = widget.sunset;
    crnTime = double.parse( convertTo24HourFormat( (DateFormat('h:mm a').format(DateTime.now())).toString() ));
   
    
    //check for is sunset done or not
    if(double.parse(convertTo24HourFormat( DateFormat('h:mm a').format(DateTime.now())).toString()) > double.parse(convertTo24HourFormat(sunset))){
        crnTime = double.parse(convertTo24HourFormat(sunset)) ;
    }
     //check for is sunrise done or not
    if(double.parse(convertTo24HourFormat( DateFormat('h:mm a').format(DateTime.now())).toString()) < double.parse(convertTo24HourFormat(sunrise))){
        crnTime = double.parse(convertTo24HourFormat(sunset)) ;
    }
    progressVal = normalize(
      crnTime,
      double.parse(convertTo24HourFormat(sunrise)),
      double.parse(convertTo24HourFormat(sunset)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return SweepGradient(
                startAngle: degToRad(0),
                endAngle: degToRad(184),
                colors: progressVal==1.0 ? [Colors.grey, Colors.grey]  : [Colors.orange.shade100, Colors.orange.withAlpha(50)],
                stops: [progressVal, progressVal],
                transform: GradientRotation(
                  degToRad(178),
                ),
              ).createShader(rect);
            },
            child: Center(
              child: CustomArc(),
            ),
          ),
          Center(
            child: Container(
              width: 120,
              height: kDiameter - 30,
              // height: 40,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 10,
                    style: BorderStyle.solid,
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 30,
                        spreadRadius: 5,
                        color: progressVal == 1.0
                              ? Colors.grey.withAlpha(
                                normalize(progressVal * 20000, 100, 255).toInt())
                              :Colors.orangeAccent.withAlpha(
                                normalize(progressVal * 20000, 100, 255).toInt()),
                        offset: Offset(1, 3))
                  ]),
              child: SleekCircularSlider(
                min: double.parse(convertTo24HourFormat(sunrise)),   //sunrise time 
                max: double.parse(convertTo24HourFormat(sunset)),  //sunset time 
                initialValue: crnTime ,//current time 
                appearance: CircularSliderAppearance(
                  startAngle: 180,
                  angleRange: 180,
                  size: kDiameter - 30,
                  customWidths: CustomSliderWidths(
                    trackWidth: 10,
                    shadowWidth: 0,
                    progressBarWidth: 01,
                    handlerSize: 10,
                  ),
                  animationEnabled: true,
                  animDurationMultiplier: 6,
                  customColors: CustomSliderColors(
                    hideShadow: true,
                    progressBarColor: Colors.transparent,
                    trackColor: Colors.transparent,
                    dotColor: progressVal==1.0 ? Colors.transparent : Colors.orange,
                  ),
                ),
                onChange: (value) {
                  // setState(() {
                  //   progressVal = normalize(value, kMinDegree, kMaxDegree);
                  // });
                },
                innerWidget: (percentage) {
                  return Center(
                    child: Text(
                       (DateFormat('h:mm a').format(DateTime.now())).toString() ,
                       style: titleStyle16.copyWith(color: deepPurple),
                      ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            child: Image.asset("assets/images/sunrise.png"),
            height: 30,
            width: 30,
            bottom: (kDiameter/2)-34,
            left: (kDiameter/2)-64,
          ),
          Positioned(
            child: Text("$sunrise",style: titleStyle12.copyWith(color: deepPurple,fontSize: 11),),
            bottom: (kDiameter/2)-50,
            left: (kDiameter/2)-64,
          ),
          Positioned(
            child: Image.asset("assets/images/sunset.png"),
            height: 30,
            width: 30,
            bottom: (kDiameter/2)-34,
            right: (kDiameter/2)-64,
          ),
          Positioned(
            child: Text("$sunset",style: titleStyle12.copyWith(color: deepPurple,fontSize: 11),),
            bottom: (kDiameter/2)-50,
            right: (kDiameter/2)-64,
          ),

        ],
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