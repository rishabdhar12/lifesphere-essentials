// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_realm_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CategoriesRealmModel extends _CategoriesRealmModel
    with RealmEntity, RealmObjectBase, RealmObject {
  CategoriesRealmModel(
    String id,
    String name,
    String desc,
    double amount,
    String duration,
    double totalDeducted,
    double amountLeft,
    DateTime startDate,
    int reset, {
    Iterable<int> txnHistory = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'desc', desc);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'duration', duration);
    RealmObjectBase.set<RealmList<int>>(
        this, 'txnHistory', RealmList<int>(txnHistory));
    RealmObjectBase.set(this, 'totalDeducted', totalDeducted);
    RealmObjectBase.set(this, 'amountLeft', amountLeft);
    RealmObjectBase.set(this, 'startDate', startDate);
    RealmObjectBase.set(this, 'reset', reset);
  }

  CategoriesRealmModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get desc => RealmObjectBase.get<String>(this, 'desc') as String;
  @override
  set desc(String value) => RealmObjectBase.set(this, 'desc', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  String get duration =>
      RealmObjectBase.get<String>(this, 'duration') as String;
  @override
  set duration(String value) => RealmObjectBase.set(this, 'duration', value);

  @override
  RealmList<int> get txnHistory =>
      RealmObjectBase.get<int>(this, 'txnHistory') as RealmList<int>;
  @override
  set txnHistory(covariant RealmList<int> value) =>
      throw RealmUnsupportedSetError();

  @override
  double get totalDeducted =>
      RealmObjectBase.get<double>(this, 'totalDeducted') as double;
  @override
  set totalDeducted(double value) =>
      RealmObjectBase.set(this, 'totalDeducted', value);

  @override
  double get amountLeft =>
      RealmObjectBase.get<double>(this, 'amountLeft') as double;
  @override
  set amountLeft(double value) =>
      RealmObjectBase.set(this, 'amountLeft', value);

  @override
  DateTime get startDate =>
      RealmObjectBase.get<DateTime>(this, 'startDate') as DateTime;
  @override
  set startDate(DateTime value) =>
      RealmObjectBase.set(this, 'startDate', value);

  @override
  int get reset => RealmObjectBase.get<int>(this, 'reset') as int;
  @override
  set reset(int value) => RealmObjectBase.set(this, 'reset', value);

  @override
  Stream<RealmObjectChanges<CategoriesRealmModel>> get changes =>
      RealmObjectBase.getChanges<CategoriesRealmModel>(this);

  @override
  Stream<RealmObjectChanges<CategoriesRealmModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CategoriesRealmModel>(this, keyPaths);

  @override
  CategoriesRealmModel freeze() =>
      RealmObjectBase.freezeObject<CategoriesRealmModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'desc': desc.toEJson(),
      'amount': amount.toEJson(),
      'duration': duration.toEJson(),
      'txnHistory': txnHistory.toEJson(),
      'totalDeducted': totalDeducted.toEJson(),
      'amountLeft': amountLeft.toEJson(),
      'startDate': startDate.toEJson(),
      'reset': reset.toEJson(),
    };
  }

  static EJsonValue _toEJson(CategoriesRealmModel value) => value.toEJson();
  static CategoriesRealmModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'desc': EJsonValue desc,
        'amount': EJsonValue amount,
        'duration': EJsonValue duration,
        'totalDeducted': EJsonValue totalDeducted,
        'amountLeft': EJsonValue amountLeft,
        'startDate': EJsonValue startDate,
        'reset': EJsonValue reset,
      } =>
        CategoriesRealmModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(desc),
          fromEJson(amount),
          fromEJson(duration),
          fromEJson(totalDeducted),
          fromEJson(amountLeft),
          fromEJson(startDate),
          fromEJson(reset),
          txnHistory: fromEJson(ejson['txnHistory']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CategoriesRealmModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, CategoriesRealmModel, 'CategoriesRealmModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('desc', RealmPropertyType.string),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('duration', RealmPropertyType.string),
      SchemaProperty('txnHistory', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
      SchemaProperty('totalDeducted', RealmPropertyType.double),
      SchemaProperty('amountLeft', RealmPropertyType.double),
      SchemaProperty('startDate', RealmPropertyType.timestamp),
      SchemaProperty('reset', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
