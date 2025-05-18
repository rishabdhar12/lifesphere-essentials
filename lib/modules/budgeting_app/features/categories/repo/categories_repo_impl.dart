import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/models/categories_model.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/models/categories_realm_model.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/repo/categories_repo.dart';
import 'package:lifesphere_essentials/service/firebase_remote_config_service/firebase_remote_config_service.dart';
import 'package:lifesphere_essentials/service/realm_service/realm_service.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl extends CategoriesRepo {
  final _remoteConfigService = getIt<RemoteConfigService>();
  final realmService = getIt<RealmService>();

  @override
  Future<Either<Failure, List<CategoriesModel>>> getCategories() async {
    try {
      final categoriesJsonList = await _remoteConfigService.getJsonData(
        'Categories',
      );

      final categoriesModelList =
          categoriesJsonList.map((json) {
            return CategoriesModel.fromJson(json);
          }).toList();

      return Right(categoriesModelList);
    } catch (e) {
      log('Error fetching categories: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> allocateCategories(
    CategoriesRealmModel model,
  ) async {
    try {
      realmService.write(() {
        realmService.add(model);
      });
      return Right("Categories allocated successfully");
    } catch (e) {
      log('Error allocating categories: $e');
      return Left(Failure(e.toString()));
    }
  }
}

// TODO: implement bloc for realm
