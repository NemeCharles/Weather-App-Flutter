import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/networking/api.dart';
import 'package:weather_app/networking/location.dart';
import 'package:weather_app/providers/provider.dart';
import 'package:weather_app/networking/weather_model.dart';
import '../utilities.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Future<WeatherAlbum> getWeather() async {
    Location location = Location();
    await location.getLocation();
    return Weather().getWeather('${location.latitude},${location.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<WeatherAlbum?>(
      future: context.watch<WeatherProvider>().getWeather(),
      builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasData) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               const SizedBox(height: 40,),
                Align(
                 child: Text(snapshot.data!.cityName,
                   style: const TextStyle(
                       fontSize: 30
                   ),
                 ),
               ),
               const SizedBox(height: 20,),
               Text(DateFormat.yMMMd('en_US').format(DateTime.parse(snapshot.data!.time.substring(0,10))),
                 style: TextStyle(
                     fontSize: 20,
                     color: Colors.grey[500]
                 ),
               ),
               const SizedBox(height: 40,),
               Container(
                 width: 230,
                 height: 40,
                 decoration: BoxDecoration(
                     color: Colors.grey.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(10)
                 ),
                 child: Row(
                   children: [
                     Container(
                       width: 115,
                       height: 40,
                       decoration: BoxDecoration(
                           gradient: const LinearGradient(
                               colors: [
                                 Color(0XFF1b7ae0),
                                 Color(0XFF2f90e9)
                               ]
                           ),
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child: const Center(
                           child: Text('Forecast',
                             style: TextStyle(fontSize: 16
                             ),
                           )
                       ),
                     ),
                     Container(
                       width: 115,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child: const Center(
                           child: Text('Air Quality',
                             style: TextStyle(fontSize: 16),
                           )
                       ),
                     ),
                   ],
                 ),
               ),
               SizedBox(
                 height: size.height * 0.453,
                 width: size.width,
                 child: Stack(
                   alignment: Alignment.bottomCenter,
                   children: [
                     Image.asset('images/${ClimateImage.hourlyClimateImage(snapshot.data!.climate,
                         int.parse(snapshot.data!.time.substring(11, snapshot.data!.time.length == 15? 12 : 13)))}.png'),
                     Positioned(
                       bottom: 30,
                       child: SizedBox(
                         width: size.width,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             WeatherData(text: 'Temp', subtext: '${snapshot.data!.temp.toInt()}°',),
                             WeatherData(text: 'Wind', subtext: '${snapshot.data!.wind.toInt()}km/h'),
                             WeatherData(text: 'Humidity', subtext: '${snapshot.data!.humidity}%')
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               const SizedBox(height: 10,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text('Today',
                       style: TextStyle(
                           fontSize: 24
                       ),
                     ),
                     GestureDetector(
                       onTap: () {
                         context.read<PageNavigator>().changePages(2);
                       },
                       child: const Text('View full report',
                         style: TextStyle(
                             color: Color(0XFF1b7ae0),
                             fontWeight: FontWeight.w500,
                             fontSize: 17
                         ),
                       ),
                     )
                   ],
                 ),
               ),
               const SizedBox(height: 40,),
               SizedBox(
                 height: 70,
                 child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                   itemCount: snapshot.data!.hourlyForecast.length,
                   itemBuilder: (context, index) {
                     final forecastData = snapshot.data!.hourlyForecast[index];
                     String hourForecast = forecastData['time'];
                     String forecastTime = hourForecast.substring(11,16);
                     double temp = forecastData['temp_c'];
                     int code = forecastData['condition']['code'];
                     String currentHour = snapshot.data!.time.substring(11, snapshot.data!.time.length == 15? 12 : 13);
                     return  HourlyForecast(
                         time: forecastTime,
                         temp: temp.toInt(),
                         currentHour: currentHour,
                         code: code,
                     );
                   },
                 ),
               )
             ],
           );
         } else if(snapshot.hasError) {
          return ErrorMessage(onPressed: () {setState(() {});},);
        }
        return const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}



class WeatherData extends StatelessWidget {
  const WeatherData({
    Key? key, required this.text, required this.subtext,
  }) : super(key: key);

  final String text;
  final String subtext;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,
          style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500]
          ),
        ),
        const SizedBox(height: 3,),
        Text(subtext,
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}

