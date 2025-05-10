import 'package:hive/hive.dart';

abstract class HiveService<T> {
  Future<Box<T>> openBox({required String boxName});
  Future<void> deleteBox({required String boxName});
}
