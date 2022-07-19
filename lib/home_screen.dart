import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/forecast_page.dart';
import 'package:weather_app/pages/profile_page.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/provider.dart';
import 'networking/location.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void onTap(int index) {
      context.read<PageNavigator>().changePages(index);
  }

  final pages = [
    const HomePage(),
    const SearchPage(),
    const ForecastPage(),
    const ProfilePage()
  ];

  void getWeather() async {
    Location location = Location();
    await location.getLocation();
    context.read<WeatherProvider>().currentLocation('${location.latitude}, ${location.longitude}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          showSelectedLabels: false,
          selectedItemColor: Colors.white,
          backgroundColor: const Color(0XFF060620),
          currentIndex: context.watch<PageNavigator>().page,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 30,),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded, size: 30,),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 30,),
              label: ''
            )
          ],
        ),
      ),
      body: SafeArea(
          child: pages[context.watch<PageNavigator>().page]
      ),
    );
  }
}

