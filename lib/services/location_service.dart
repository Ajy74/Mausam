
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class LocationService extends GetxService{

  @override
  void onReady() {
    super.onReady();
  }

   String subLocality ='' ;
   String locality = '' ;


   Future<bool> checkGps()  async{
      return  await Geolocator.isLocationServiceEnabled();
   }


  Future<List> getLocation()async{
    LocationPermission permission;
    List coardinate = [];

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //if denied
        permission = await Geolocator.requestPermission();
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      // permission = await Geolocator.requestPermission();
      // Get.offAllNamed("/request_permision_again");
      return [];
    } 
    if(permission != LocationPermission.denied && permission != LocationPermission.deniedForever){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        // print("***>>>>>****");
        // print("${position.toString()}");//Latitude: 19.1975415, Longitude: 73.1023961
        List lat_long = position.toString().split(',');
        String lat = lat_long[0].toString().split(':').last.removeAllWhitespace;
        String long = lat_long[1].toString().split(':').last.removeAllWhitespace;
        coardinate.add(lat);
        coardinate.add(long);

      
        List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(lat), double.parse(long));
        //  print("***address****");
        // for(int i=0 ; i<placemarks.length ; i++){
        //     print("index $i--> ${placemarks[0]}");
        // }
        locality = placemarks[0].locality.toString();
        subLocality = placemarks[0].subLocality.toString();
        
    }
   
    return coardinate;
  }

  

}