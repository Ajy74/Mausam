import 'package:flutter/material.dart';

import '../../res/theme/colors.dart';
import '../../utilities/text_styles.dart';
import '../home/home_screen.dart';
import 'gradient_text.dart';

class FutureListStyle extends StatelessWidget {
  FutureListStyle({super.key,required this.iconPath,required this.temp,required this.title,required this.subTitle});

  String iconPath;
  String temp;
  String title;
  String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: ListTile(
          // visualDensity: VisualDensity.adaptivePlatformDensity,
          leading: Image.asset("${iconPath}",width: 70,height: 70,),
          // title: Text("33*C",style: tempeartureText.copyWith(fontSize: 40),),
          subtitle: Container(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                SizedBox(width: 10,),
                GradientText(
                  '$temp',
                  style: tempeartureText.copyWith(fontSize: 40),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                    deepPurple,
                    deepPurple.withOpacity(.9),
                    deepBlue,
                  ]),
                ),
                SizedBox(width: 2,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 17),
                  child: CustomPaint(
                      size: Size(9, 9),
                      painter: CircleIconPainter(
                        strokeGradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [  
                            deepPurple,
                            deepPurple.withOpacity(.4),
                            deepPurple.withOpacity(.4),
                          ], // Set your desired gradient colors
                        ),
                        strokeWidth: 3.0, // Set your desired stroke width
                      ),
                  ),
                ),
                SizedBox(width: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$title",style: titleStyle14.copyWith(color: Colors.black,fontSize: 15),),
                    Text("$subTitle",style: titleStyle12.copyWith(fontSize: 13,color: Colors.black.withOpacity(.6)),),
                  ],
                )
            ],
          ),
        ),
      );
  }
}