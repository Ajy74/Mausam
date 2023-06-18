import 'dart:async';

import 'package:get/get.dart';

class ForCastDayController extends GetxController{

  final dateIndex = 0.obs;
  final loader = true.obs;

  @override
  void onReady() {
    forLoader();
    // print("lll->>$isDataLoaded");
    super.onReady();
  }
  
  getDateIndex(int currentIndex){
    dateIndex.value = currentIndex;
  }

  void forLoader() async {
    await Timer.periodic(Duration(seconds: 2), (timer) {
        loader.value = false;
     });
  }

}