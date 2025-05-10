import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'hive_service.dart';

@Injectable(as: HiveService)
class HiveServiceImpl<T> implements HiveService<T> {
  @override
  Future<Box<T>> openBox({required String boxName}) async {
    return await Hive.openBox<T>(boxName);
  }

  @override
  Future<void> deleteBox({required String boxName}) async {
    final box = await Hive.openBox<T>(boxName);
    await box.deleteFromDisk();
  }
}
