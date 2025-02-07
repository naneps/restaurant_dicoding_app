import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/screens/home_screen.dart';
import 'package:restaurant_dicoding_app/screens/restaurant_detail_screen.dart';
import 'package:restaurant_dicoding_app/screens/restaurant_list_screen.dart';
import 'package:restaurant_dicoding_app/screens/splash_screen.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String restaurantLst = '/list-restaurant';
  static const String restaurantDetail = '/restaurant_detail';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case restaurantLst:
        return MaterialPageRoute(builder: (_) => RestaurantListScreen());
      case restaurantDetail:
        return MaterialPageRoute(
          builder: (context) =>
              RestaurantDetailScreen(id: settings.arguments as String),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('404 Not Found')),
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
