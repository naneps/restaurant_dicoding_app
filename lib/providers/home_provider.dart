import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/screens/restaurant_favorite_screen.dart';
import 'package:restaurant_dicoding_app/screens/restaurant_list_screen.dart';
import 'package:restaurant_dicoding_app/screens/setting_screen.dart';

class HomeProvider extends ChangeNotifier {
  int _activeIndex = 0;
  List<Widget> screens = [
    RestaurantListScreen(),
    RestaurantFavoriteScreen(),
    SettingScreen(),
  ];
  int get activeIndex => _activeIndex;
  void setActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}
