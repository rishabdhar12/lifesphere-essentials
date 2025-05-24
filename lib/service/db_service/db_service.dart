// database_service.dart
import 'package:sqflite/sqflite.dart';

abstract class DatabaseService {
  Future<Database> get database;

  // Generic CRUD operations
  Future<int> insert(String table, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  });
  Future<int> update(
    String table,
    Map<String, dynamic> data,
    String where,
    List<dynamic> whereArgs,
  );
  Future<int> delete(String table, String where, List<dynamic> whereArgs);
  Future<void> execute(String sql, [List<dynamic>? arguments]);
  Future<void> close();
}
