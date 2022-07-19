import 'package:flutter/material.dart';
import 'package:weather_app/networking/weather_model.dart';
import '../networking/api.dart';


class WeatherProvider with ChangeNotifier {

  late String city;

  Future<WeatherAlbum> getWeather() async {
    await Future.delayed(const Duration(seconds: 1));
    return Weather().getWeather(city);
  }

  void currentLocation(String bearings) {
    city = bearings;
    notifyListeners();
  }
  void newCity(String cityName) {
    city = cityName;
    notifyListeners();
  }

}


class PageNavigator with ChangeNotifier {
  int page = 0;
  void changePages(int index){
    page = index;
    notifyListeners();
  }
}