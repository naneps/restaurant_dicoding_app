import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_dicoding_app/models/customer_review.model.dart';
import 'package:restaurant_dicoding_app/models/restaurant_category.model.dart';
import 'package:restaurant_dicoding_app/models/restaurant_menu.model.dart';

part 'restaurant.model.g.dart';

@JsonSerializable()
class RestaurantModel extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final double? rating;
  final List<RestaurantCategory>? categories;
  final RestaurantMenu? menus;
  final List<CustomerReview>? customerReviews;

  const RestaurantModel({
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
        customerReviews
      ];

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'city': city,
        'address': address,
        'pictureId': pictureId,
        'rating': rating,
        'categories': jsonEncode(categories?.map((e) => e.toJson()).toList()),
        'menus': menus?.toJson(),
        'customerReviews':
            jsonEncode(customerReviews?.map((e) => e.toJson()).toList()),
      };
}
