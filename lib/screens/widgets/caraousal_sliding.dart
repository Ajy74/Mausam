import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/utilities/text_styles.dart';

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  final List<String> titles = ["Today's Storm possiblity Storm possiblityStorm possiblity",'high alert possiblityStorm possiblity'];
  final List<String> subtitles = ['Subtitle Storm possiblityStorm possiblity ','for storm'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.0,
      child: Stack(
        children: [
          CarouselSlider(
            items: _buildSlides(),
            options: CarouselOptions(
              height: 95.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicators(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSlides() {
    return titles.map((title) {
      int index = titles.indexOf(title);
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(16),
          gradient: mainGredient,
                      
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              
            children: [
              Center(
                child: Text(
                  title,
                  style: titleStyle16.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                subtitles[index],
                style: titleStyle14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildIndicators() {
    return titles.map((title) {
      int index = titles.indexOf(title);
      return Container(
        width: 5.0,
        height: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.white : deepPurple,
        ),
      );
    }).toList();
  }
}
