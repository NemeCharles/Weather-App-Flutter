import'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/networking/weather_model.dart';

const apiKey = '88a175adbb134e769f8112231221207';

class Weather {
  Future<WeatherAlbum> getWeather(String location) async {
      http.Response response = await http.get(Uri.parse('https://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&q=$location'));
      if(response.statusCode ==200) {
        return WeatherAlbum.fromJson(jsonDecode(response.body));
      } else {throw Exception('Failed to load Album');}
  }
}