import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/provider.dart';
import 'package:weather_app/networking/weather_model.dart';
import 'package:weather_app/utilities.dart';


class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<WeatherAlbum>(
      future: context.watch<WeatherProvider>().getWeather(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center( child: CircularProgressIndicator(),);
        } else if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              const Align(
                alignment: Alignment.center,
                child: Text('Forecast report',
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Today',
                      style: TextStyle(
                          fontSize: 24
                      ),
                    ),
                    Text(DateFormat.yMMMd('en_US').format(DateTime.parse(snapshot.data!.time.substring(0,10))),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  height: 70,
                  child:  ListView.builder(
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
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Next forecast',
                      style: TextStyle(
                          fontSize: 24
                      ),
                    ),
                    Icon(Icons.calendar_today_outlined, color: Colors.white,)
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: size.height * 0.46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                    itemCount: snapshot.data!.dailyForecast.length - 1,
                    itemBuilder: (context, index) {
                      final dailyCast = snapshot.data!.dailyForecast[index + 1];
                      var parseDay = DateTime.parse(dailyCast['date']);
                      String forecastDay = DateFormat.EEEE().format(parseDay);
                      String forecastMonth = DateFormat.MMMd().format(parseDay);
                      double tempDouble = dailyCast['day']['mintemp_c'];
                      int code = dailyCast['day']['condition']['code'];
                      int temp = tempDouble.toInt();
                      return DailyForecast(
                        weekDay: forecastDay,
                        month: forecastMonth,
                        temp: temp,
                        code: code,
                      );
                    }),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorMessage(onPressed: () {setState(() {});});
        }
        return const Center( child: CircularProgressIndicator(),);
      });
  }
}




