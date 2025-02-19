import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';
import 'package:restaurant_dicoding_app/services/restaurant_favorite_service.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantFavoriteService favoriteService;
  RestaurantState _restaurantState = RestaurantLoadingState();
  RestaurantRepository repo = RestaurantRepository();
  TextEditingController searchController = TextEditingController();
  bool _showFieldReview = false;
  bool _isSendingReview = false;

  TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isFavorite = false;
  RestaurantDetailProvider({required this.favoriteService});
  bool get isFavorite => _isFavorite;
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
      throw Exception('Request failed: $e');
    } finally {
      Future.delayed(const Duration(milliseconds: 1000), () {
        _isSendingReview = false;
        reviewController.clear();
        getRestaurant(id);
      });
    }
  }

  Future<void> getRestaurant(String id) async {
    try {
      final result = await repo.getRestaurant(id);
      if (result == null) {
        _restaurantState = RestaurantEmptyState();
      } else {
        _restaurantState = RestaurantLoadedDetailState(result);
        _isFavorite = await favoriteService.isFavorite(id);
      }
    } catch (e) {
      _restaurantState = RestaurantErrorState('Failed to fetch restaurant: $e');
    } finally {
      Future.delayed(const Duration(milliseconds: 1500), () {
        notifyListeners();
      });
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      if (await favoriteService.isFavorite(id)) {
        await favoriteService.deleteFavorite(id);
        _isFavorite = false;
      } else {
        await favoriteService.insertFavorite(
          (state as RestaurantLoadedDetailState).restaurant,
        );
        _isFavorite = true;
      }
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  void toggleShowFieldReview() {
    _showFieldReview = !_showFieldReview;
    notifyListeners();
  }
}