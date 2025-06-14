import 'package:flutter/material.dart';
import 'package:weather_guru/utilities/app_constants.dart';
import 'package:weather_guru/utilities/text_styles.dart';

class ConditionItem extends StatelessWidget {
  ConditionItem({super.key,this.icon,this.title,this.subTitle});

  Widget? icon;
  String? title;
  String? subTitle;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,child: icon,),
          const SizedBox(width:sizeBox5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text("$title",style: titleStyle12.copyWith(color: Colors.black.withOpacity(.5)),),
                Text("$subTitle",style: titleStyle12.copyWith(color: Colors.black.withOpacity(.8)),),
            ],
          ),
        ],
      ),
    );
  }
}