import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

import 'database_service.dart';

@Singleton(as: DatabaseService)
class SembastDatabaseService implements DatabaseService {
  Completer<Database>? _dbCompleter;

  @override
  Future<Database> get database async {
    if (_dbCompleter == null) {
      _dbCompleter = Completer();
      await _initDatabase();
    }
    return _dbCompleter!.future;
  }

  Future _initDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(appDir.path, 'my_database.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbCompleter!.complete(database);
  }

  @override
  Future<int> insert(String storeName, Map<String, dynamic> data) async {
    final store = intMapStoreFactory.store(storeName);
    final db = await database;
    return await store.add(db, data);
  }

  @override
  Future<int> update(
    String storeName,
    Map<String, dynamic> data,
    dynamic key,
  ) async {
    final store = intMapStoreFactory.store(storeName);
    final db = await database;
    return await store.update(
      db,
      data,
      finder: Finder(filter: Filter.byKey(key)),
    );
  }

  @override
  Future<int> delete(String storeName, dynamic key) async {
    final store = intMapStoreFactory.store(storeName);
    final db = await database;
    return await store.delete(db, finder: Finder(filter: Filter.byKey(key)));
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String storeName) async {
    final store = intMapStoreFactory.store(storeName);
    final db = await database;
    return (await store.find(db)).map((snapshot) {
      final data = snapshot.value;
      data['key'] = snapshot.key;
      return data as Map<String, dynamic>;
    }).toList();
  }

  @override
  Future<Map<String, dynamic>?> get(String storeName, dynamic key) async {
    final store = intMapStoreFactory.store(storeName);
    final db = await database;
    final record = await store.record(key).get(db);
    if (record != null) {
      final data = Map<String, dynamic>.from(record);
      data['key'] = key;
      return data;
    }
    return null;
  }

  @override
  Future<void> clearStore(String storeName) async {
    final store = intMapStoreFactory.store(storeName);
    final db = await database;
    await store.delete(db);
  }
}
