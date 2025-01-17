import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  String _selectedDistance = 'Nearest';
  RangeValues _priceRange = const RangeValues(0, 100);
  String _selectedFoodType = 'All';
  String _selectedRestaurantType = 'All';

  RangeValues get priceRange => _priceRange;
  // Getter methods
  String get selectedDistance => _selectedDistance;
  String get selectedFoodType => _selectedFoodType;
  String get selectedRestaurantType => _selectedRestaurantType;

  // Reset filters
  void resetFilters() {
    _selectedDistance = 'Terdekat';
    _priceRange = const RangeValues(0, 100);
    _selectedFoodType = 'All';
    _selectedRestaurantType = 'All';
    notifyListeners();
  }

  // Setter methods with notifyListeners()
  void setDistance(String value) {
    _selectedDistance = value;
    notifyListeners();
  }

  void setFoodType(String value) {
    _selectedFoodType = value;
    notifyListeners();
  }

  void setPriceRange(RangeValues values) {
    _priceRange = values;
    notifyListeners();
  }

  void setRestaurantType(String value) {
    _selectedRestaurantType = value;
    notifyListeners();
  }
}
