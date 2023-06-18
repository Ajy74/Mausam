import 'package:flutter/material.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/utilities/text_styles.dart';


class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.buttonColor = deepPurple,
    this.textColor = Colors.white,
    required this.title ,
    required this.onPress ,
    this.width = 60 ,
    this.height = 50 ,
    this.loading = false ,
  });

  final bool loading;
  final String title;
  final double height,width;
  final VoidCallback onPress;
  final Color textColor,buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,

      child: Container(
    
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
    
        child: loading ? 
        Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: Colors.white,
            ),
        )
        ) :
        Center(
          child: Text(title, style: titleStyle16.copyWith(color: Colors.white), ),
        ) ,
    
      ),
    );
  }
}