import 'package:restaurant_dicoding_app/models/customer_review.model.dart';
import 'package:restaurant_dicoding_app/models/restaurant_item.model.dart';

class RestaurantMenus {
  List<RestaurantMenu>? foods;
  List<RestaurantMenu>? drinks;

  RestaurantMenus({this.foods, this.drinks});

  factory RestaurantMenus.fromJson(Map<String, dynamic> json) {
    return RestaurantMenus(
      foods: json['foods'] == null
          ? null
          : List<RestaurantMenu>.from(
              json['foods'].map((x) => RestaurantMenu.fromJson(x))),
      drinks: json['drinks'] == null
          ? null
          : List<RestaurantMenu>.from(
              json['drinks'].map((x) => RestaurantMenu.fromJson(x))),
    );
  }
}

// Model utama untuk restoran
class RestaurantModel {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  double? rating;
  List<RestaurantCategory>? categories;
  RestaurantMenus? menus;
  List<CustomerReview>? customerReviews;

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
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      rating: json['rating']?.toDouble(),
      categories: json['categories'] == null
          ? null
          : List<RestaurantCategory>.from(
              json['categories'].map((x) => RestaurantCategory.fromJson(x))),
      menus: json['menus'] == null
          ? null
          : RestaurantMenus.fromJson(json['menus']),
      customerReviews: json['customerReviews'] == null
          ? null
          : List<CustomerReview>.from(
              json['customerReviews'].map((x) => CustomerReview.fromJson(x))),
    );
  }
}
