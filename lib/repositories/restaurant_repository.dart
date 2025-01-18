import 'dart:convert';

import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/services/restaurant_service.dart';

class RestaurantRepository {
  final service = RestaurantService();
  Future<void> addReview({required String id, name, review}) async {
    try {
      final response =
          await service.addReview(id: id, name: name, review: review);
      print("REVIEW: ${response.statusCode} ${response.body}");
    } catch (e) {
      print("ERROR ADD REVIEW: $e");
      throw Exception('Request failed: $e');
    }
  }

  Future<RestaurantModel?> getRestaurant(String id) async {
    try {
      final response = await service.getRestaurant(id);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['restaurant'];
        return RestaurantModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR GET RESTAURANT: $e");
      throw Exception('Request failed: $e');
    }
  }

  Future<List<RestaurantModel>?> getRestaurants() async {
    try {
      final response = await service.getRestaurants();
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['restaurants'];

        return data
            .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("ERROR GET RESTAURANTS: $e");
      throw Exception('Request failed: $e');
    }
  }

  Future<List<RestaurantModel>?> searchRestaurants(String value) async {
    try {
      final response = await service.searchRestaurants(value);
      print(response.body);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['restaurants'];

        return data
            .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("ERROR GET RESTAURANTS: $e");
      throw Exception('Request failed: $e');
    }
  }
}
