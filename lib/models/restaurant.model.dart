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
  bool isFavorite;

  @JsonKey(toJson: _categoriesToJson)
  final List<RestaurantCategory>? categories;

  @JsonKey(toJson: _menusToJson)
  final RestaurantMenu? menus;

  @JsonKey(toJson: _reviewsToJson)
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
  factory RestaurantModel.fromSqlite(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      rating: json['rating'],
      categories: jsonDecode(json['categories']) != null
          ? List<RestaurantCategory>.from(jsonDecode(json['categories']).map(
              (x) => RestaurantCategory.fromJson(x),
            ))
          : null,
      menus: jsonDecode(json['menus']) != null
          ? RestaurantMenu.fromJson(jsonDecode(json['menus']))
          : null,
      customerReviews: jsonDecode(json['customerReviews']) != null
          ? List<CustomerReview>.from(jsonDecode(json['customerReviews']).map(
              (x) => CustomerReview.fromJson(x),
            ))
          : null,
      isFavorite: json['isFavorite'] == 1 ? true : false,
    );
  }

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

  static List<Map<String, dynamic>>? _categoriesToJson(
      List<RestaurantCategory>? categories) {
    return categories?.map((e) => e.toJson()).toList();
  }

  static Map<String, dynamic>? _menusToJson(RestaurantMenu? menus) {
    return menus?.toJson();
  }

  static List<Map<String, dynamic>>? _reviewsToJson(
      List<CustomerReview>? reviews) {
    return reviews?.map((e) => e.toJson()).toList();
  }
}
