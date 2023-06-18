class ForCastModel {
  Location? location;
  Current? current;
  Forecast? forecast;
  Alerts? alerts;

  ForCastModel({this.location, this.current, this.forecast, this.alerts});

  ForCastModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
    alerts =
        json['alerts'] != null ? new Alerts.fromJson(json['alerts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    if (this.alerts != null) {
      data['alerts'] = this.alerts!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  String? tzId;
  String? localtime;

  Location({this.name, this.region, this.country, this.tzId, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    tzId = json['tz_id'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['region'] = this.region;
    data['country'] = this.country;
    data['tz_id'] = this.tzId;
    data['localtime'] = this.localtime;
    return data;
  }
}

class Current {
  String? lastUpdated;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windKph;
  String? windDir;
  double? pressureMb;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? visKm;
  double? uv;

  Current(
      {this.lastUpdated,
      this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windKph,
      this.windDir,
      this.pressureMb,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.feelslikeF,
      this.visKm,
      this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb'];
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c'];
    feelslikeF = json['feelslike_f'];
    visKm = json['vis_km'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_updated'] = this.lastUpdated;
    data['temp_c'] = this.tempC;
    data['temp_f'] = this.tempF;
    data['is_day'] = this.isDay;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_kph'] = this.windKph;
    data['wind_dir'] = this.windDir;
    data['pressure_mb'] = this.pressureMb;
    data['humidity'] = this.humidity;
    data['cloud'] = this.cloud;
    data['feelslike_c'] = this.feelslikeC;
    data['feelslike_f'] = this.feelslikeF;
    data['vis_km'] = this.visKm;
    data['uv'] = this.uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    return data;
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(new Forecastday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecastday != null) {
      data['forecastday'] = this.forecastday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Forecastday {
  String? date;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({this.date, this.day, this.astro, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? new Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add(new Hour.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.day != null) {
      data['day'] = this.day!.toJson();
    }
    if (this.astro != null) {
      data['astro'] = this.astro!.toJson();
    }
    if (this.hour != null) {
      data['hour'] = this.hour!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  double? maxtempC;
  double? maxtempF;
  double? mintempC;
  double? mintempF;
  double? avgtempC;
  double? avgtempF;
  double? maxwindKph;
  double? totalsnowCm;
  int? dailyChanceOfRain;
  int? dailyChanceOfSnow;
  Condition? condition;
  double? uv;

  Day(
      {this.maxtempC,
      this.maxtempF,
      this.mintempC,
      this.mintempF,
      this.avgtempC,
      this.avgtempF,
      this.maxwindKph,
      this.totalsnowCm,
      this.dailyChanceOfRain,
      this.dailyChanceOfSnow,
      this.condition,
      this.uv});

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    avgtempC = json['avgtemp_c'];
    avgtempF = json['avgtemp_f'];
    maxwindKph = json['maxwind_kph'];
    totalsnowCm = json['totalsnow_cm'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    dailyChanceOfSnow = json['daily_chance_of_snow'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxtemp_c'] = this.maxtempC;
    data['maxtemp_f'] = this.maxtempF;
    data['mintemp_c'] = this.mintempC;
    data['mintemp_f'] = this.mintempF;
    data['avgtemp_c'] = this.avgtempC;
    data['avgtemp_f'] = this.avgtempF;
    data['maxwind_kph'] = this.maxwindKph;
    data['totalsnow_cm'] = this.totalsnowCm;
    data['daily_chance_of_rain'] = this.dailyChanceOfRain;
    data['daily_chance_of_snow'] = this.dailyChanceOfSnow;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['uv'] = this.uv;
    return data;
  }
}

class Astro {
  String? sunrise;
  String? sunset;

  Astro({this.sunrise, this.sunset});

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

class Hour {
  String? time;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windKph;
  String? windDir;
  double? pressureMb;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? heatindexC;
  int? chanceOfRain;
  int? chanceOfSnow;
  double? visKm;

  Hour(
      {this.time,
      this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windKph,
      this.windDir,
      this.pressureMb,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.feelslikeF,
      this.heatindexC,
      this.chanceOfRain,
      this.chanceOfSnow,
      this.visKm});

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb'];
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c'];
    feelslikeF = json['feelslike_f'];
    heatindexC = json['heatindex_c'];
    chanceOfRain = json['chance_of_rain'];
    chanceOfSnow = json['chance_of_snow'];
    visKm = json['vis_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['temp_c'] = this.tempC;
    data['temp_f'] = this.tempF;
    data['is_day'] = this.isDay;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_kph'] = this.windKph;
    data['wind_dir'] = this.windDir;
    data['pressure_mb'] = this.pressureMb;
    data['humidity'] = this.humidity;
    data['cloud'] = this.cloud;
    data['feelslike_c'] = this.feelslikeC;
    data['feelslike_f'] = this.feelslikeF;
    data['heatindex_c'] = this.heatindexC;
    data['chance_of_rain'] = this.chanceOfRain;
    data['chance_of_snow'] = this.chanceOfSnow;
    data['vis_km'] = this.visKm;
    return data;
  }
}

class Alerts {
  List<Alert>? alert;

  Alerts({this.alert});

  Alerts.fromJson(Map<String, dynamic> json) {
    if (json['alert'] != null) {
      alert = <Alert>[];
      json['alert'].forEach((v) {
        alert!.add(new Alert.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alert != null) {
      data['alert'] = this.alert!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alert {
  String? headline;
  String? msgtype;
  String? urgency;
  String? areas;
  String? event;
  String? note;
  String? effective;
  String? expires;
  String? desc;
  String? instruction;

  Alert(
      {this.headline,
      this.msgtype,
      this.urgency,
      this.areas,
      this.event,
      this.note,
      this.effective,
      this.expires,
      this.desc,
      this.instruction});

  Alert.fromJson(Map<String, dynamic> json) {
    headline = json['headline'];
    msgtype = json['msgtype'];
    urgency = json['urgency'];
    areas = json['areas'];
    event = json['event'];
    note = json['note'];
    effective = json['effective'];
    expires = json['expires'];
    desc = json['desc'];
    instruction = json['instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headline'] = this.headline;
    data['msgtype'] = this.msgtype;
    data['urgency'] = this.urgency;
    data['areas'] = this.areas;
    data['event'] = this.event;
    data['note'] = this.note;
    data['effective'] = this.effective;
    data['expires'] = this.expires;
    data['desc'] = this.desc;
    data['instruction'] = this.instruction;
    return data;
  }
}