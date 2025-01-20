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
  RestaurantRepository repo = RestaurantRepository();
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  bool _showFieldReview = false;
  bool _isSendingReview = false;
  TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool get isSearching => _isSearching;
  bool get isSendingReview => _isSendingReview;

  bool get showFieldReview => _showFieldReview;

  RestaurantState get state => _restaurantState;

  Future<void> addReview({required String id}) async {
    try {
      _isSendingReview = true;
      notifyListeners();
      await repo.addReview(
        id: id,
        name: "Ahmad",
        review: reviewController.text,
      );
    } catch (e) {
      print("ERROR ADD REVIEW: $e");
      throw Exception('Request failed: $e');
    } finally {
      Future.delayed(const Duration(milliseconds: 1000), () {
        _isSendingReview = false;
        reviewController.clear();
        getRestaurant(id);
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> getRestaurant(String id) async {
    try {
      Future.delayed(const Duration(milliseconds: 500), () async {
        final result = await repo.getRestaurant(id);
        if (result == null) {
          _restaurantState = RestaurantEmptyState();
        } else {
          _restaurantState = RestaurantLoadedDetailState(result);
        }
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        notifyListeners();
      });
    } catch (e) {
      _restaurantState = RestaurantErrorState('Failed to fetch restaurant: $e');
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
      _restaurantState = RestaurantErrorState(
        'Failed to fetch restaurants: $e',
      );
    } finally {
      Future.delayed(const Duration(milliseconds: 1500), () {
        notifyListeners();
      });
    }
  }

  refreshPage() {
    _restaurantState = RestaurantLoadingState();
    getRestaurants();
    notifyListeners();
  }

  void searchRestaurants(String value) async {
    _restaurantState = RestaurantLoadingState();
    notifyListeners();
    _isSearching = true;

    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final result = await repo.searchRestaurants(value);

        if (result == null || result.isEmpty) {
          _restaurantState = RestaurantEmptyState();
        } else {
          _restaurantState = RestaurantLoadedState(result);
        }

        if (value.isEmpty) {
          _isSearching = false;
        }
      } catch (e) {
        _restaurantState =
            RestaurantErrorState('Failed to fetch restaurants: $e');
      } finally {
        Future.delayed(const Duration(milliseconds: 500), () {
          notifyListeners();
        });
      }
    });
  }

  void toggleShowFieldReview() {
    _showFieldReview = !_showFieldReview;
    notifyListeners();
  }
}

sealed class RestaurantState {}
