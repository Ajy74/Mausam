class FavCityModel {

  int? id;
  String? city;
  String? country;
  String? state;
  double? temp;
  String? iconPath;
  String? weekDay;
  String? date;
  int? isDay;
 
  FavCityModel({
    this.id,
    this.city,
    this.country,
    this.state,
    this.temp,
    this.iconPath,
    this.weekDay,
    this.date,
    this.isDay,
  });

  FavCityModel.fromJson(Map<String, dynamic> json){
    id=json['id'];
    city=json['city'];
    country=json['country'];
    state=json['state'];
    temp=json['temp'];
    iconPath=json['iconPath'];
    weekDay=json['weekDay'];
    date=json['date'];
    isDay=json['isDay'];
  }


  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id']=this.id;
    data['city']=this.city;
    data['state']=this.state;
    data['country']=this.country;
    data['temp']=this.temp;
    data['iconPath']=this.iconPath;
    data['weekDay']=this.weekDay;
    data['date']=this.date;
    data['isDay']=this.isDay;

    return data;
  }

}