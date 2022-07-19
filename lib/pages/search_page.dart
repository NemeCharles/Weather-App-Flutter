import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40,),
          const Align(
            alignment: Alignment.center,
            child: Text('Pick location',
              style: TextStyle(
                fontSize: 29,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const TextShii(text: 'Find the area or city that you want to know'),
          const SizedBox(height: 10,),
          const TextShii(text: 'the detailed weather info at this time'),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 55,
                  width: 250,
                  child: TextField(
                    onChanged: (value) {
                      cityName = value;
                    },
                    style: const TextStyle(
                      fontSize: 18
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.6),
                        fontSize: 18
                      )
                    ),
                  )
              ),
              const SizedBox(width: 15,),
              TextButton(
                onPressed: () {
                  context.read<WeatherProvider>().newCity(cityName);
                  context.read<PageNavigator>().changePages(0);
                },
                child: const Icon(Icons.location_on_outlined, color: Colors.white, size: 30,),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.2)),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(57, 55)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))
                  )
                ),
              )
            ],
          ),
          const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const ForeCastWidgets(
                      temp: '38°',
                      color: Color(0XFF1b7ae0),
                      condition: 'Cloudy',
                      cityName: 'California',
                      image: 'cloudy',
                    ),
                    const SizedBox(height: 20,),
                    ForeCastWidgets(
                      temp: '26°',
                      color: Colors.grey.withOpacity(0.1),
                      condition: 'Bright',
                      cityName: 'London',
                      image: 'sunny',
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 30,),
                    ForeCastWidgets(
                      temp: '27°',
                      color: Colors.grey.withOpacity(0.1),
                      condition: 'Bright',
                      cityName: 'Paris',
                      image: 'sunny',
                    ),
                    const SizedBox(height: 20,),
                    ForeCastWidgets(
                      temp: '26°',
                      color: Colors.grey.withOpacity(0.1),
                      condition: 'Bright',
                      cityName: 'Milan',
                      image: 'sunny',
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class ForeCastWidgets extends StatelessWidget {
  const ForeCastWidgets({
    Key? key, required this.color, required this.temp, required this.condition, required this.cityName, required this.image,
  }) : super(key: key);

  final Color color;
  final String temp;
  final String condition;
  final String cityName;
  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 145,
      width: size.width * 0.416,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(temp,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(condition,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300
                    ),
                  )
                ],
              ),
              Image.asset('images/${image}_2d.png', height: 50,)
            ],
          ),
          Text(cityName,
            style: const TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}


class TextShii extends StatelessWidget {
  const TextShii({
    Key? key, required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        color: Colors.grey[500],
        fontSize: 17
      ),
    );
  }
}
