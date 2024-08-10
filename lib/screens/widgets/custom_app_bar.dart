import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_guru/utilities/app_constants.dart';
import 'package:weather_guru/utilities/text_styles.dart';


class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key,this.leftChild,this.rightChild,this.title,this.titleWidget,this.isTitle=false});
  
  Widget? leftChild; 
  Widget? rightChild;
  Widget? titleWidget;
  String? title;  
  bool? isTitle;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        width: mobileWidth,
        height: 55, 
        padding: const EdgeInsets.symmetric(vertical: 3),
        child:
            isTitle == true ?
            Row(
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 5),
                   child: Transform.translate(
                      offset: const Offset(-14, 0),
                      child: const BackButton(),
                    ),
                 ),
                const SizedBox(width: sizeBox5,),
                Text("$title",style: titleStyle20,)
              ],
            )
            :
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Expanded(child: SizedBox(
                  width: Get.width*.7 ,
                  child:leftChild,
                ),),
                SizedBox(child: Container(child: rightChild,)),
              ],
            ),
      
      ),
    ) ;
  }
}