import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:weather_guru/controller/searchController.dart';
import 'package:weather_guru/controller/storage/store_city_controller.dart';
import 'package:weather_guru/res/theme/colors.dart';
import 'package:weather_guru/screens/widgets/round_button.dart';
import 'package:weather_guru/utilities/text_styles.dart';

import '../../controller/advertisement/adController.dart';
import '../../utilities/app_constants.dart';
import '../widgets/futureListStyle.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  LocationSearchController locationSearchController = Get.put(LocationSearchController());
  StoreCityController _storeCityController = Get.put(StoreCityController());
  //  AdControlller adControlller = Get.put(AdControlller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Search Location",style: titleStyle22.copyWith(color: deepPurple),),
        foregroundColor: deepPurple,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:CSCPicker(
                      layout: Layout.vertical,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: deepPurple),
                      ),
                      disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: deepPurple.withOpacity(.2),   
                      ),

                      cityDropdownLabel: "*City",
                      countryDropdownLabel: "*Country",
                      stateDropdownLabel: "*State",

                      searchBarRadius: 14,
                      dropdownDialogRadius: 20,
                      
                      selectedItemStyle: const TextStyle(
                        color: deepPurple,
                        fontSize: 16,
                      ),
                      
                      onCountryChanged: (country) {
                       if(country != null){
                           locationSearchController.countryValue.value = country;
                       }
                      },
                      onStateChanged: (state) {
                       if(state != null){
                          locationSearchController.stateValue.value = state!;
                       }
                      },
                      onCityChanged: (city) {
                       if(city!= null){
                        locationSearchController.cityValue.value = city!;
                       }
                      },
                    
                    ), 
              ),

             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 10),
               child: SizedBox(
                width: double.maxFinite,
                height: 50,
                 child: Obx(() {
                  return   RoundButton(
                      loading: locationSearchController.isBtnLoader.value,
                      title: "Check Weather", 
                      onPress: () {
                       
                        if(locationSearchController.cityValue.value.isNotEmpty && locationSearchController.stateValue.value.isNotEmpty && locationSearchController.countryValue.value.isNotEmpty ){
                           locationSearchController.isBtnLoader.value = true;
                            locationSearchController.loadCityWeather();  
                        }
                        else{
                           Fluttertoast.showToast(
                              msg: locationSearchController.countryValue.isEmpty ? "please choose Country" :
                                  (locationSearchController.stateValue.isEmpty ? "please choose State":"please choose City"),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: lightPurple,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      },
                    ) ;
                 }),
               ),
             ),

              SizedBox(height: 10,),
 

              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5),
                child: Text("Favorite City",style: titleStyle22black,),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Container(
                      child: Obx(() {
                        // print("${_storeCityController.cityList[0]}");
                          return _storeCityController.cityList.length >0 ?
                            GlowingOverscrollIndicator(
                              axisDirection: AxisDirection.down,
                              color: Colors.transparent,
                              showLeading: false,
                              showTrailing: false,
                              child: NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (notification) {
                                  notification.disallowIndicator(); // Disables the overscroll glow effect
                                  return true;
                                },
                                child:SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        cityList(),
                                      ],
                                    ),
                                  )
                              )
                            )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Not Saved Any Favorite City",
                                style: titleStyle16.copyWith(color: deepPurple.withOpacity(.7)
                            ),),
                            ],
                          ); 
                        }, ),
                    )
                  ),
                ),
              ),

          ],
      ),
    );
  }
  
  
  cityList() {
    return Padding(
      padding: const EdgeInsets.only(top:16.0,left: 20,right: 20,bottom: 65),
       child: 
              ListView.builder(
                clipBehavior: Clip.hardEdge,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount:_storeCityController.cityList.length,
                itemBuilder: (BuildContext context,index){
                  return Hero(
                    tag: Key('favCity'),
                    child: AnimationConfiguration.staggeredGrid(
                      position: index, 
                      columnCount: 1, 
                      child:SlideAnimation(
                        child: FadeInAnimation(
                          delay: Duration(milliseconds: 200),
                          child: GestureDetector(
                            onLongPress: () async{
                               Vibration.vibrate(duration: 100);
                              //for delete option
                              locationSearchController.openDialog(index);
                            },
                            onTap: () async {
                              locationSearchController.countryValue.value =_storeCityController.cityList[index].country.toString();
                              locationSearchController.stateValue.value =_storeCityController.cityList[index].state.toString();
                              locationSearchController.cityValue.value = _storeCityController.cityList[index].city.toString();
                              locationSearchController.favCityId.value = index;
                  
                             await locationSearchController.loadCityWeather();
                              //for open to new page to show latest data
                              Get.toNamed("/search_detail_screen",arguments: {"city":"${_storeCityController.cityList[index].city.toString()}"});
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12,),
                                  Text(
                                    _storeCityController.cityList[index].city.toString(),
                                    style: titleStyle20.copyWith(color: deepBlue),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ) ,
                                  FutureListStyle(
                                    iconPath:_storeCityController.cityList[index].iconPath.toString(),
                                    temp:_storeCityController.cityList[index].temp.toString().split(".").first,
                                    title:_storeCityController.cityList[index].weekDay.toString(),
                                    subTitle:_storeCityController.cityList[index].date.toString()
                                  ),
                                  index == _storeCityController.cityList.length-1 ?Container():lineBar(),
                                ],
                              ),
                          ),
                        ),
                      ) ,
                    ),
                  ) ;
              
              })
    ) ;
  }

}