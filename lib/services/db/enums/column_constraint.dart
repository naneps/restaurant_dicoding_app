enum ColumnConstraint { primaryKey, nullable, notNull, autoIncrement, unique }

extension ColumnConstraintExtension on ColumnConstraint {
  String get sqlConstraint {
    switch (this) {
      case ColumnConstraint.primaryKey:
        return 'PRIMARY KEY';
      case ColumnConstraint.nullable:
        return 'NULL';
      case ColumnConstraint.autoIncrement:
        return 'AUTOINCREMENT';
      case ColumnConstraint.unique:
        return 'UNIQUE';
      case ColumnConstraint.notNull:
        return 'NOT NULL';
    }
  }
}
