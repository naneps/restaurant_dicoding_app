import 'package:equatable/equatable.dart';
import 'package:restaurant_dicoding_app/services/db/db_service.dart';

class Table extends Equatable {
  final String name;
  final List<Column> columns;

  const Table({required this.name, required this.columns});
  @override
  List<Object?> get props => [name, columns];

  String sqlDefinition() {
    final columnDefinitions = columns.map((column) {
      final type = column.type.sqlType;
      final constraints = column.constraint.sqlConstraint;
      return '${column.name} $type $constraints';
    }).join(', ');
    return 'CREATE TABLE $name ($columnDefinitions)';
  }
}
