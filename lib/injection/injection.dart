import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/models/categories_realm_model.dart';
import 'package:lifesphere_essentials/service/realm_service/realm_service.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() async {
  $initGetIt(getIt);
  await getIt<RealmService>().init([CategoriesRealmModel.schema]);
}
