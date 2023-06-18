import 'package:flutter/material.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/utilities/text_styles.dart';

class ConditionCardWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;

  const ConditionCardWidget({
    required this.iconPath,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: deepPurple.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(iconPath,height: 50,width: 40,),
          SizedBox(height: 5),
          Text(
            title,
            style:titleStyle20.copyWith(fontSize: 16,color: deepPurple),
          ),
          // SizedBox(height: 0),
          Text(
            value,
            style:titleStyle16.copyWith(color: lightPurple),
          ),
        ],
      ),
    );
  }
}
