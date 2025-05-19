import 'package:sembast/sembast.dart';

abstract class DatabaseService {
  Future<Database> get database;

  Future<int> insert(String storeName, Map<String, dynamic> data);
  Future<int> update(String storeName, Map<String, dynamic> data, dynamic key);
  Future<int> delete(String storeName, dynamic key);
  Future<List<Map<String, dynamic>>> getAll(String storeName);
  Future<Map<String, dynamic>?> get(String storeName, dynamic key);
  Future<void> clearStore(String storeName);
}
