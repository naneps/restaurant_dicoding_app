import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/services/db/db_service.dart';

class RestaurantFavoriteService extends DatabaseService {
  final String _tableName = 'restaurant_favorite';

  RestaurantFavoriteService()
      : super(databaseName: 'db_restaurant', databaseVersion: 1);

  Future<void> deleteFavorite(String id) async {
    try {
      await delete(_tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantModel?> getFavoriteById(String id) async {
    try {
      final results = await query(_tableName, where: 'id = ?', whereArgs: [id]);
      if (results.isNotEmpty) {
        return RestaurantModel.fromSqlite(results.first);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RestaurantModel>> getFavorites() async {
    try {
      final results = await database.query(_tableName);
      return results.map((json) => RestaurantModel.fromSqlite(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertFavorite(RestaurantModel restaurant) async {
    try {
      await insert(_tableName, restaurant.toMap());
    } catch (e) {
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
              constraint: ColumnConstraint.nullable,
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
              constraint: ColumnConstraint.nullable,
            ),
            Column(
              name: 'menus',
              type: ColumnType.text,
              constraint: ColumnConstraint.nullable,
            ),
            Column(
              name: 'customerReviews',
              type: ColumnType.text,
              constraint: ColumnConstraint.nullable,
            ),
          ],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}