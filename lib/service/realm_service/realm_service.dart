import 'package:realm/realm.dart';

abstract class RealmService {
  Future<void> init(List<SchemaObject> schemas);
  Realm get realm;

  T add<T extends RealmObject>(T object);
  List<T> getAll<T extends RealmObject>();
  T? getById<T extends RealmObject>(dynamic id);
  void update<T extends RealmObject>(T object);
  void delete<T extends RealmObject>(T object);

  void close();

  void write(void Function() callback);
}
