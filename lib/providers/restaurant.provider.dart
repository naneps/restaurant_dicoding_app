import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';

class RestaurantEmptyState extends RestaurantState {}

class RestaurantErrorState extends RestaurantState {
  final String errorMessage;
  RestaurantErrorState(this.errorMessage);
}

class RestaurantLoadedDetailState extends RestaurantState {
  final RestaurantModel restaurant;
  RestaurantLoadedDetailState(this.restaurant);
}

class RestaurantLoadedState extends RestaurantState {
  final List<RestaurantModel> restaurants;
  RestaurantLoadedState(this.restaurants);
}

class RestaurantLoadingState extends RestaurantState {}

class RestaurantProvider extends ChangeNotifier {
  RestaurantState _restaurantState = RestaurantLoadingState();
  final RestaurantRepository repo = RestaurantRepository();

  RestaurantState get state => _restaurantState;

  void getRestaurant(String id) async {
    try {
      final result = await repo.getRestaurant(id);
      if (result == null) {
        _restaurantState = RestaurantEmptyState();
      } else {
        _restaurantState = RestaurantLoadedDetailState(result);
      }
    } catch (e) {
      _restaurantState = RestaurantErrorState('Failed to fetch restaurant: $e');
    } finally {
      notifyListeners();
    }
  }

  void getRestaurants() async {
    try {
      final result = await repo.getRestaurants();
      if (result == null || result.isEmpty) {
        _restaurantState = RestaurantEmptyState();
      } else {
        _restaurantState = RestaurantLoadedState(result);
      }
    } catch (e) {
      _restaurantState =
          RestaurantErrorState('Failed to fetch restaurants: $e');
    } finally {
      notifyListeners();
    }
  }
}

sealed class RestaurantState {}
