import 'package:restaurant_dicoding_app/models/restaurant.model.dart';

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

sealed class RestaurantState {}
