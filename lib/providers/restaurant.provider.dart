import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';
import 'package:restaurant_dicoding_app/services/restaurant_favorite_service.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantFavoriteService favoriteService;

  RestaurantState _restaurantState = RestaurantLoadingState();
  RestaurantRepository repo = RestaurantRepository();
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  final formKey = GlobalKey<FormState>();
  RestaurantProvider({required this.favoriteService});
  bool get isSearching => _isSearching;

  RestaurantState get state => _restaurantState;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> getRestaurants() async {
    try {
      final result = await repo.getRestaurants();
      if (result == null || result.isEmpty) {
        _restaurantState = RestaurantEmptyState();
      } else {
        final favoriteRestaurants = await favoriteService.getFavorites();

        final markedRestaurants = result.map((restaurant) {
          final isFavorite =
              favoriteRestaurants.any((fav) => fav.id == restaurant.id);
          return restaurant.copyWith(isFavorite: isFavorite);
        }).toList();

        _restaurantState = RestaurantLoadedState(markedRestaurants);
      }
    } catch (e) {
      _restaurantState =
          RestaurantErrorState('Failed to fetch restaurants: $e');
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

  Future<void> toggleFavorite(RestaurantModel restaurant) async {
    try {
      if (restaurant.isFavorite) {
        await favoriteService.deleteFavorite(restaurant.id!);
      } else {
        await favoriteService.insertFavorite(restaurant);
      }

      final currentState = _restaurantState;
      if (currentState is RestaurantLoadedState) {
        final updatedRestaurants = currentState.restaurants.map((r) {
          if (r.id == restaurant.id) {
            return r.copyWith(isFavorite: !restaurant.isFavorite);
          }
          return r;
        }).toList();

        _restaurantState = RestaurantLoadedState(updatedRestaurants);
        notifyListeners();
      }
    } catch (e) {
    }
  }
}