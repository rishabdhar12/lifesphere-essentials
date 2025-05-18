import 'package:realm/realm.dart';

part 'categories_realm_model.realm.dart';

@RealmModel()
class _CategoriesRealmModel {
  @PrimaryKey()
  late String id;

  late String name;
  late String desc;
  late double amount;
  late String duration;
  late List<int> txnHistory;
  late double totalDeducted;
  late double amountLeft;
  late DateTime startDate;
  late int reset; // 0 -> false 1 -> true
}
