import 'package:flutter/material.dart';
import 'package:weather_guru/res/theme/colors.dart';

import '../../utilities/app_constants.dart';
import '../../utilities/text_styles.dart';
import '../home/home_screen.dart';
import 'gradient_text.dart';

class ForecastCard extends StatelessWidget {
  ForecastCard({super.key,required this.title1,required this.title2,required this.iconPath,required this.temp,required this.isCurrent});
  // ForecastCard({super.key,this.isCurrent=true});

  String title1;
  String title2;
  String iconPath;
  String temp;
  bool isCurrent; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: sidePadding12,right: 6),
      child: Container(
        height: 190,
        width: 90,
        decoration: isCurrent==true ? 
          BoxDecoration(
            gradient: mainGredient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(
              color: deepBlue.withOpacity(.2),
              offset: const Offset(2, 3),
              blurRadius: 5
            )]
          )  
          : 
          BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
      child: Stack(
        alignment: Alignment.center,clipBehavior: Clip.hardEdge,
        children: [
         if( isCurrent == true)
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.hardEdge,
                child: Container(color: Colors.white.withOpacity(.1),),
            ),
          if( isCurrent == true)
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.hardEdge,
                child: Container(color: Colors.white.withOpacity(.1),),
            ),
    
          if( isCurrent == false)
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.hardEdge,
                child: Container(color: Colors.deepPurple.withOpacity(.1),),
            ),  
    
          Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              const Spacer(),
              if(isCurrent == true)  
                Text("$title1",textAlign: TextAlign.center,style: titleStyle16black.copyWith(color: Colors.white),),
              if(isCurrent==false)
                Text("$title1",textAlign: TextAlign.center,style: titleStyle16black,),  
    
              if(isCurrent==true)  
                Text("$title2",textAlign: TextAlign.center,style: titleStyle14,),
              if(isCurrent==false)  
                Text("$title2",textAlign: TextAlign.center,style: titleStyle14.copyWith(color: Colors.black.withOpacity(.7)),),
              const Spacer(),
              Image(image: AssetImage("$iconPath"),width: 50,height: 50,),
              const Spacer(),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(isCurrent==false)
                     Text("$temp",style: titleStyle22.copyWith(color: Colors.black,fontSize: 20),),
                    if(isCurrent==true)
                     GradientText(
                      '$temp',
                      style: tempeartureText.copyWith(fontSize: 25),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                        Colors.white,
                        Colors.white.withOpacity(.9),
                        deepBlue,
                      ]),
                    ),
                    const SizedBox(width:sizeBox5),
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child:
                         isCurrent == true? 
                          CustomPaint(
                              size: Size(5, 5),
                              painter: CircleIconPainter(
                                strokeGradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [  
                                    Colors.white.withOpacity(.8),
                                    Colors.white.withOpacity(.8),
                                  ], // Set your desired gradient colors
                                ),
                                strokeWidth: 1.2, // Set your desired stroke width
                              ),
                          )
                        :  
                          CustomPaint(
                              size: const Size(5, 5),
                              painter: CircleIconPainter(
                                strokeGradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [  
                                    Colors.black,
                                    Colors.black,
                                  ], // Set your desired gradient colors
                                ),
                                strokeWidth: 1.2, // Set your desired stroke width
                              ),
                          ),
    
                    )
                  ],
                ),
                const Spacer(),
            ],
          ),
          ),
          
        ],
      ),
      ),
    );
  }
}