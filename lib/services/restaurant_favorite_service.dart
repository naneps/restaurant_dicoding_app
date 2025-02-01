import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/services/db/db_service.dart';

class RestaurantFavoriteService extends DatabaseService {
  final String _tableName = 'restaurant_favorite';

  RestaurantFavoriteService()
      : super(databaseName: 'db_restaurant', databaseVersion: 1);

  Future<void> deleteFavorite(String id) async {
    try {
      await delete(_tableName, where: 'id = ?', whereArgs: [id]);
      print('Favorite with ID "$id" deleted successfully.');
    } catch (e) {
      print('Error deleting favorite with ID "$id": $e');
      rethrow;
    }
  }

  Future<RestaurantModel?> getFavoriteById(String id) async {
    try {
      final results = await query(_tableName, where: 'id = ?', whereArgs: [id]);
      if (results.isNotEmpty) {
        print('Favorite with ID "$id" retrieved successfully.');
        return RestaurantModel.fromJson(results.first);
      } else {
        print('No favorite found with ID "$id".');
        return null;
      }
    } catch (e) {
      print('Error retrieving favorite with ID "$id": $e');
      rethrow;
    }
  }

  Future<List<RestaurantModel>> getFavorites() async {
    try {
      print('Retrieving favorites...');
      print('database: $database');
      final results = await database.query(_tableName);
      print('Retrieved ${results.length} favorite(s) successfully.');
      return results.map((json) => RestaurantModel.fromJson(json)).toList();
    } catch (e) {
      print('Error retrieving favorites: $e');
      rethrow;
    }
  }

  Future<void> insertFavorite(RestaurantModel restaurant) async {
    try {
      await insert(_tableName, restaurant.toMap());
      print('Favorite inserted successfully with data: ${restaurant.toJson()}');
    } catch (e) {
      print('Error inserting favorite: $e');
      rethrow;
    }
  }

  Future<bool> isFavorite(String id) async {
    try {
      final results = await query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      return results.isNotEmpty;
    } catch (e) {
      print('Error checking favorite: $e');
      rethrow;
    }
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    try {
      await createTable(
        db,
        Table(
          name: _tableName,
          columns: [
            Column(
              name: 'id',
              type: ColumnType.text,
              constraint: ColumnConstraint.primaryKey,
            ),
            Column(
              name: 'name',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'description',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'city',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'address',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'pictureId',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'rating',
              type: ColumnType.real,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'categories',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'menus',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
            Column(
              name: 'customerReviews',
              type: ColumnType.text,
              constraint: ColumnConstraint.notNull,
            ),
          ],
        ),
      );
      print('Table "$_tableName" created successfully.');
    } catch (e) {
      print('Error creating table ON RESTAURANT SERVICE "$_tableName": $e');
      rethrow;
    }
  }
}
