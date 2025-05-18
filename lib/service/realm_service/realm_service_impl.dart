import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/service/realm_service/realm_service.dart';
import 'package:realm/realm.dart';

@Injectable(as: RealmService)
class RealmServiceImpl implements RealmService {
  late Realm _realm;

  @override
  Future<void> init(List<SchemaObject> schemas) async {
    final config = Configuration.local(schemas);
    _realm = Realm(config);
  }

  @override
  Realm get realm => _realm;

  @override
  T add<T extends RealmObject>(T object) {
    late T addedObject;
    _realm.write(() {
      addedObject = _realm.add(object);
    });
    return addedObject;
  }

  @override
  List<T> getAll<T extends RealmObject>() {
    return _realm.all<T>().toList();
  }

  @override
  T? getById<T extends RealmObject>(dynamic id) {
    return _realm.find<T>(id);
  }

  @override
  void update<T extends RealmObject>(T object) {
    _realm.write(() {
      _realm.add(object, update: true);
    });
  }

  @override
  void delete<T extends RealmObject>(T object) {
    _realm.write(() {
      _realm.delete(object);
    });
  }

  @override
  void write(void Function() callback) {
    _realm.write(callback);
  }

  @override
  void close() {
    _realm.close();
  }
}
