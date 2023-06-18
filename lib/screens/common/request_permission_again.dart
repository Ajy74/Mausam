import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/utilities/text_styles.dart';

class RequestAgainPermisson extends StatelessWidget {
  const RequestAgainPermisson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: Icon(Icons.location_off_rounded, size: 120, color: deepPurple),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => exit(0),
                      child: Container(
                        height: 45,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: deepPurple,),
                          borderRadius: BorderRadius.circular(12),
                          color: deepPurple
                        ),
                        child: Text("Exit App",style: titleStyle16.copyWith(color: Colors.white),),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        LocationPermission permission = await Geolocator.checkPermission();
                        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
                          await openAppSettings();
                          exit(0);
                        } else {
                          Get.offAllNamed("/home_screen");
                        }
                      },
                      child: Container(
                          height: 45,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                          border: Border.all(color: deepPurple,),
                          borderRadius: BorderRadius.circular(12),
                          color: deepPurple
                        ),
                        child: Text("Open Settings",style: titleStyle16.copyWith(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}