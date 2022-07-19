import 'package:flutter/material.dart';
import 'package:weather_app/networking/weather_model.dart';


class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text('An error occurred',
            style: TextStyle(
                fontSize: 18
            ),
          ),
        ),
        const SizedBox(height: 10,),
        TextButton(
          onPressed: onPressed,
          child: const Text('Try Again',
            style: TextStyle(
                fontSize: 17
            ),
          ),
        )
      ],
    );
  }
}

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({
    Key? key,
    required this.time, required this.temp, required this.currentHour, required this.code,
  }) : super(key: key);

  final String time;
  final int temp;
  final String currentHour;
  final int code;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int currentHourInt = int.parse(currentHour);
    int timeInt = int.parse(time.substring(0,2));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          print('${size.width}, ${size.height}');
        },
        child: Container(
          height: 65,
          width: 130,
          decoration: BoxDecoration(
              color: timeInt == currentHourInt ? null : Colors.grey.withOpacity(0.1),
              gradient: timeInt == currentHourInt ? const LinearGradient(
                  colors: [
                    Color(0XFF1b7ae0),
                    Color(0XFF2088e7)
                  ]
              ) : null,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('images/${ClimateImage.hourlyClimateImage(code, timeInt)}_2d.png', height: 45,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(time,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 7,),
                    Row(
                      children: [
                        Text('${temp.toString()}°',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    Key? key, required this.weekDay, required this.month, required this.temp, required this.code,
  }) : super(key: key);

  final String weekDay;
  final String month;
  final int temp;
  final int code;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Container(
        height: 80,
        width: 330,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(weekDay,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(month,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500]
                    ),
                  )
                ],
              ),
            ),
            Text('${temp.toString()}°',
              style: const TextStyle(
                fontSize: 55,
              ),
            ),
            Image.asset('images/${ClimateImage.dailyClimateIImage(code)}_2d.png', height: 60,)
          ],
        ),
      ),
    );
  }
}

