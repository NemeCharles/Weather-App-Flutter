import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/providers/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => PageNavigator())
      ],
      child:  const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0XFF060620),
      ),
      home: const HomeScreen(),
    );
  }
}
