import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_guru/models/fav_city_model.dart';

class DBHelper{
  static Database? _db;
  static final int _version =1;
  static final String _tableName = "FavCity";

  static Future<void> initDb() async{

    if(_db != null){   //ie. it already been initialize
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'cities.db';    //database is created
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version){
          if (kDebugMode) {
            print("creating a new one");
          }
          return db.execute(     //table is created in database
              "CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "city STRING, country STRING, state STRING, "
              "temp DOUBLE, iconPath STRING, "
              "weekDay STRING, date STRING, "
              "isDay INTEGER)"
          );
        }
      );
    } catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future <int> insert(FavCityModel? city) async{
    return await _db?.insert( _tableName, city!.toJson() )??1;  //1 is random number
  }
  
  static Future<List<Map<String, dynamic>>> query() async {
    if (kDebugMode) {
        print("query function called");
      }
    return await _db!.query(_tableName);
  }

  static delete(FavCityModel city)async{
    return await _db!.delete(_tableName, where: 'id=?' , whereArgs: [city.id]);
  }

  static upadte(int id,double temp,String iconPath,String weekDay,String date,int isDay)async{
   return await _db!.rawUpdate(''' 
      UPDATE FavCity
      SET temp = ?,iconPath = ?,weekDay = ?,date = ?,isDay = ?
      WHERE id = ?
    ''', [temp,iconPath,weekDay,date,isDay,id] );  //means set 1 to isCompleted of id coming
  }



}