import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class WeatherService{

  static const BASE_URL =  'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;


  WeatherService(this.apiKey);

  Future<Weather>getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    // GET PERMISSION FORM USER
    LocationPermission  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // FETCH THE CURRENT LOCATION
  Position position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high);

    // CONVERT THE LOCATION INTO A LIST OF PLACEMARK OBJECTS
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.altitude, position.longitude);

    //EXTRACT THE CITY NAME FORM THE FIRST PLACEMARK
  String? city = placemarks [0].locality;
    return city ?? "";
  }
}