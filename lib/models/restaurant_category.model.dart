import 'package:json_annotation/json_annotation.dart';

part 'restaurant_category.model.g.dart';

@JsonSerializable()
class RestaurantCategory {
  String? name;
  RestaurantCategory({this.name});

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) =>
      _$RestaurantCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantCategoryToJson(this);
}
