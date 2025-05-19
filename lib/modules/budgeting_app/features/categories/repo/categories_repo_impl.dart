import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/dto/add_categories_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/models/categories_model.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/repo/categories_repo.dart';
import 'package:lifesphere_essentials/service/database_service/database_service.dart';
import 'package:lifesphere_essentials/service/firebase_remote_config_service/firebase_remote_config_service.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl extends CategoriesRepo {
  final _remoteConfigService = getIt<RemoteConfigService>();
  final _dbService = getIt<DatabaseService>();

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
  Future<Either<Failure, String>> allocateCategory({
    required AddCategoriesDto addCategoriesDto,
  }) async {
    try {
      final categoryData = {
        'id': addCategoriesDto.id,
        'name': addCategoriesDto.name,
        'desc': addCategoriesDto.desc,
        'amount': addCategoriesDto.amount,
        'duration': addCategoriesDto.duration,
        'txnHistory': jsonEncode(addCategoriesDto.txnHistory),
        'totalDeducted': addCategoriesDto.totalDeducted,
        'amountLeft': addCategoriesDto.amountLeft,
        'stateDate': addCategoriesDto.stateDate,
        'reset': addCategoriesDto.reset,
      };

      final id = await _dbService.insert('categories', categoryData);

      return Right(id.toString());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteCategory({
    required String categoryName,
  }) async {
    try {
      await _dbService.delete('categories', categoryName);

      return Right("$categoryName deleted successfully");
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
