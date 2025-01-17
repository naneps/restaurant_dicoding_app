import 'dart:async';

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
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  bool _showFieldReview = false;
  TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool get isSearching => _isSearching;

  bool get showFieldReview => _showFieldReview;

  RestaurantState get state => _restaurantState;

  Future<void> addReview({required String id}) async {
    try {
      await repo.addReview(
          id: id, name: "Nannnde", review: reviewController.text);
      getRestaurant(id);
      reviewController.clear();
    } catch (e) {
      print("ERROR ADD REVIEW: $e");
      throw Exception('Request failed: $e');
    }
  }

  void clear() {
    _restaurantState = RestaurantLoadingState();
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
    clear();
  }

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

  Future<void> getRestaurants() async {
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

  refreshPage() {
    _restaurantState = RestaurantLoadingState();
    getRestaurants();
    notifyListeners();
  }

  void searchRestaurants(String value) async {
    // Cancel previous debounce if any
    _debounce?.cancel();

    // Set a new debounce with delay
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final result = await repo.searchRestaurants(value);
        _isSearching = true;

        if (result == null || result.isEmpty) {
          _restaurantState = RestaurantEmptyState();
        } else {
          _restaurantState = RestaurantLoadedState(result);
        }

        if (value.isEmpty) {
          _isSearching = false;
        }

        notifyListeners();
      } catch (e) {
        _restaurantState =
            RestaurantErrorState('Failed to fetch restaurants: $e');
        notifyListeners();
      }
    });
  }

  void toggleShowFieldReview() {
    _showFieldReview = !_showFieldReview;
    notifyListeners();
  }
}

sealed class RestaurantState {}
