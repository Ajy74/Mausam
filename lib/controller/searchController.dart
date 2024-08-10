import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:weather_guru/controller/storage/store_city_controller.dart';
import 'package:weather_guru/models/fav_city_model.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/services/searchCity.dart';
import 'package:weather_guru/utilities/text_styles.dart';

import '../models/forcast_weather_model.dart';
import '../services/internet_connection_service.dart';
import '../utilities/app_constants.dart';

class LocationSearchController extends GetxController{

   InternetServices _internetServices = Get.put(InternetServices());
   StoreCityController _storeCityController = Get.put(StoreCityController());

   final isInternetConnected = true.obs;  
   final isDataLoaded = false.obs;
   late ForCastModel weatherData ;
   final currentIcon = ''.obs;

   final countryValue = ''.obs;
   final stateValue = ''.obs;
   final cityValue = ''.obs;
   
   final favCityId = 0.obs;
   final isBtnLoader = false.obs;

   final isFavCityDataLoaded = false.obs;

   @override
  void onReady() {
    _storeCityController.getCities();
    super.onReady();
  }


  Future<void> loadCityWeather() async{
     //then cheking for internet 
    isInternetConnected.value = await _internetServices.execute(InternetConnectionChecker());
    if(isInternetConnected.value == false){
      //move to no internet connection page
      Get.offAllNamed("/no_internet_screen");
      return;
    }

     //for fetching api data
    final obj = CityCurrent(city: cityValue.value,state: stateValue.value,country: countryValue.value);
    weatherData  =  await obj.fetchForcast() ;
    // print(weatherData.current!.condition!.text);
    currentIcon.value  = findIconPath(
        (weatherData.current!.condition!.text).toString().toLowerCase(), 
       (weatherData.current!.isDay)!.toInt()
      );

    //check if new search 
    if(isBtnLoader.value==true){
     await storeToDatabase();
    }
    //if old then update
    if(isBtnLoader.value==false){
       await updateToDatabase();
    }

    isBtnLoader.value = false;
    isDataLoaded.value = false;
  }
  
  Future<void> storeToDatabase() async{
    
    //to store data to database.......
     int value = await _storeCityController.addCity(
      city: FavCityModel(
        city: cityValue.value,
        country: countryValue.value,
        state: stateValue.value,
        iconPath: findIconPath(weatherData.current!.condition!.text.toString(), weatherData.current!.isDay!.toInt()),
        weekDay: DateFormat.EEEE().format(DateTime.parse(
                        (weatherData.forecast!.forecastday![0].date).toString() )) ,
        temp: double.parse(weatherData.current!.tempC.toString().split('.').first),
        date: DateFormat('d MMM, yy').format(DateTime.parse( (weatherData.forecast!.forecastday![0].date).toString() )),
        isDay: weatherData.current!.isDay
      )
     );

     //empty these
     countryValue.value = '';
     stateValue.value = '';
     cityValue.value = '';
    
    //to get all cities in list available at storController
     await _storeCityController.getCities();
  }

  Future<void> updateToDatabase() async{
    
    //to update data to database.......
    await _storeCityController.cityUpdate(
      favCityId.value, 
      double.parse(weatherData.current!.tempC.toString().split('.').first)  , 
      findIconPath(weatherData.current!.condition!.text.toString(), weatherData.current!.isDay!.toInt()), 
       DateFormat.EEEE().format(DateTime.parse(
                        (weatherData.forecast!.forecastday![0].date).toString() )) , 
      DateFormat('d MMM, yy').format(DateTime.parse( (weatherData.forecast!.forecastday![0].date).toString() )), 
      weatherData.current!.isDay!
    );

     //empty these
     countryValue.value = '';
     stateValue.value = '';
     cityValue.value = '';
    
    //to get all cities in list available at storController
     await _storeCityController.getCities();
     isFavCityDataLoaded.value = true;
    
  }

  openDialog(int index){

    Get.defaultDialog(
      
      title: "",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Do you want to delete ${_storeCityController.cityList[index].city} ?",
                style: titleStyle22black,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30), 
                shape: const StadiumBorder(side: BorderSide(color: deepPurple)),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: () {
                //on cancel
              },
              child: const Text("No",style: TextStyle(color: deepPurple),),
            ),
            const Spacer(), // Add spacing between the buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30), 
                shape: const StadiumBorder(),
                backgroundColor: deepPurple,
                elevation: 0,
              ),
              onPressed: () {
                // on confirm
                _storeCityController.delete(_storeCityController.cityList[index]);
                Get.back();
              },
              child: const Text("Yes",style: TextStyle(color: Colors.white),),
            ),
              ],
            ),
          )
        ],
      ),
      buttonColor: deepPurple,
    );

  }
  
 

}