enum ColumnType { text, integer, real, blob }

extension ColumnTypeExtension on ColumnType {
  String get sqlType {
    switch (this) {
      case ColumnType.text:
        return 'TEXT';
      case ColumnType.integer:
        return 'INTEGER';
      case ColumnType.real:
        return 'REAL';
      case ColumnType.blob:
        return 'BLOB';
    }
  }
}
