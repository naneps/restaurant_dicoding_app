import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_dicoding_app/models/restaurant_menu_item.model.dart';

part 'restaurant_menu.model.g.dart';

@JsonSerializable()
class RestaurantMenu {
  @JsonKey(toJson: _foodsToJson)
  List<RestaurantMenuItem>? foods;

  @JsonKey(toJson: _drinksToJson)
  List<RestaurantMenuItem>? drinks;

  RestaurantMenu({this.foods, this.drinks});

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMenuFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantMenuToJson(this);

  static List<Map<String, dynamic>>? _drinksToJson(
      List<RestaurantMenuItem>? drinks) {
    return drinks?.map((item) => item.toJson()).toList();
  }

  // Custom toJson functions for foods and drinks
  static List<Map<String, dynamic>>? _foodsToJson(
      List<RestaurantMenuItem>? foods) {
    return foods?.map((item) => item.toJson()).toList();
  }
}
