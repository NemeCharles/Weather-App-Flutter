
class WeatherAlbum {
  final String cityName;
  final String time;
  final double temp;
  final double wind;
  final int humidity;
  final List hourlyForecast;
  final List dailyForecast;
  final int climate;

  WeatherAlbum({
    required this.cityName,
    required this.time,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.hourlyForecast,
    required this.dailyForecast,
    required this.climate
});

  factory WeatherAlbum.fromJson(Map<String, dynamic> json) {
    return WeatherAlbum(
      cityName: json['location']['name'],
      time: json['location']['localtime'],
      temp: json['current']['temp_c'],
      wind: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      hourlyForecast: json['forecast']['forecastday'][0]['hour'],
      dailyForecast: json['forecast']['forecastday'],
      climate: json['current']['condition']['code']
    );
  }
}

class ClimateImage {
  static String hourlyClimateImage(int code, int time) {
    if(code == 1072 || code == 1198 || code == 1201 || code == 1240 || code == 1243 || code == 1009 ){
      return 'rainy';
    } else if(code == 1192 || code == 1195 || code == 1273 || code == 1276 || code == 1246 || code == 1087){
      return 'thunder';
    } else if(code == 1279 || code == 1282 || code == 1066 || code == 1069 || code == 1114 || code == 1117) {
      return 'snow';
    } else if (code >= 1204 && code <=1237 || code >= 1249 && code <= 1264) {
      return 'snow';
    } else if(code == 1003 || code == 1006 || code == 1030 || code == 1063 ) {
      if(time >= 7 && time < 19) {
        return 'cloudy';
      } else {return 'cloudyn';}
    } return time >= 7 && time < 19 ? 'sunny' : 'night';
  }

  static String dailyClimateIImage(int code) {
    if(code == 1072 || code == 1198 || code == 1201 || code == 1240 || code == 1243 || code == 1009){
      return 'rainy';
    } else if(code == 1192 || code == 1195 || code == 1273 || code == 1276 || code == 1246 || code == 1087){
      return 'thunder';
    } else if(code == 1279 || code == 1282 || code == 1066 || code == 1069 || code == 1114 || code == 1117) {
      return 'snow';
    } else if (code >= 1204 && code <=1237 || code >= 1249 && code <= 1264) {
      return 'snow';
    } else if(code == 1003 || code == 1006 || code == 1030 || code == 1063 ) {
        return 'cloudy';
    } return 'sunny';
  }
}