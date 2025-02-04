import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/services/restaurant_favorite_service.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  RestaurantState _restaurantState = RestaurantEmptyState();
  final RestaurantFavoriteService _favoriteService;

  RestaurantFavoriteProvider(this._favoriteService);
  RestaurantState get state => _restaurantState;

  void getFavorites() async {
    try {
      final result = await _favoriteService.getFavorites();
      print('getFavorites: $result');
      if (result.isEmpty) {
        _restaurantState = RestaurantEmptyState();
        notifyListeners();
        return;
      }
      _restaurantState = RestaurantLoadedState(result);
    } catch (e) {
      _restaurantState =
          RestaurantErrorState('Failed to fetch restaurants: $e');
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await _favoriteService.deleteFavorite(id);
      getFavorites();
    } catch (e) {
      _restaurantState =
          RestaurantErrorState('Failed to fetch restaurants: $e');
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }
}
