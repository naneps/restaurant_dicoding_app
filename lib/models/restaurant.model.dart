import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_dicoding_app/models/customer_review.model.dart';
import 'package:restaurant_dicoding_app/models/restaurant_category.model.dart';
import 'package:restaurant_dicoding_app/models/restaurant_menu.model.dart';

part 'restaurant.model.g.dart';

@JsonSerializable()
@JsonSerializable()
class RestaurantModel extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final double? rating;
  bool isFavorite;

  @JsonKey(toJson: _categoriesToJson, fromJson: _categoriesFromJson)
  final List<RestaurantCategory>? categories;

  @JsonKey(toJson: _menusToJson, fromJson: _menusFromJson)
  final RestaurantMenu? menus;

  @JsonKey(toJson: _reviewsToJson, fromJson: _reviewsFromJson)
  final List<CustomerReview>? customerReviews;

  RestaurantModel({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.rating,
    this.categories,
    this.menus,
    this.customerReviews,
    this.isFavorite = false,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        rating,
        categories,
        menus,
        customerReviews,
      ];

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? description,
    String? city,
    String? address,
    String? pictureId,
    double? rating,
    List<RestaurantCategory>? categories,
    RestaurantMenu? menus,
    List<CustomerReview>? customerReviews,
    bool? isFavorite,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      city: city ?? this.city,
      isFavorite: isFavorite ?? this.isFavorite,
      address: address ?? this.address,
      pictureId: pictureId ?? this.pictureId,
      rating: rating ?? this.rating,
      categories: categories ?? this.categories,
      menus: menus ?? this.menus,
      customerReviews: customerReviews ?? this.customerReviews,
    );
  }

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'address': address,
      'pictureId': pictureId,
      'rating': rating,
      'categories': jsonEncode(categories?.map((e) => e.toJson()).toList()),
      'menus': jsonEncode(menus?.toJson()),
      'customerReviews':
          jsonEncode(customerReviews?.map((e) => e.toJson()).toList()),
    };
  }

  static List<RestaurantCategory>? _categoriesFromJson(dynamic categories) {
    if (categories is String) {
      return jsonDecode(categories)
          .map<RestaurantCategory>((e) => RestaurantCategory.fromJson(e))
          .toList();
    }
    return categories
        .map<RestaurantCategory>((e) => RestaurantCategory.fromJson(e))
        .toList();
  }

  static List<Map<String, dynamic>>? _categoriesToJson(
      List<RestaurantCategory>? categories) {
    return categories?.map((e) => e.toJson()).toList();
  }

  static RestaurantMenu? _menusFromJson(dynamic menus) {
    if (menus is String) {
      return RestaurantMenu.fromJson(jsonDecode(menus));
    }
    return RestaurantMenu.fromJson(menus);
  }

  static Map<String, dynamic>? _menusToJson(RestaurantMenu? menus) {
    return menus?.toJson();
  }

  static _reviewsFromJson(dynamic reviews) {
    if (reviews is String) {
      return CustomerReview.fromJson(jsonDecode(reviews));
    }
    return CustomerReview.fromJson(reviews);
  }

  static List<Map<String, dynamic>>? _reviewsToJson(
      List<CustomerReview>? reviews) {
    return reviews?.map((e) => e.toJson()).toList();
  }
}
