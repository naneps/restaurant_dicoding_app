import 'package:equatable/equatable.dart';
import 'package:restaurant_dicoding_app/services/db/enums/column_constraint.dart';
import 'package:restaurant_dicoding_app/services/db/enums/column_type.dart';

class Column extends Equatable {
  final String name;
  final ColumnType type;
  ColumnConstraint constraint;
  Column({
    required this.name,
    required this.type,
    this.constraint = ColumnConstraint.nullable,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, type, constraint];
}
