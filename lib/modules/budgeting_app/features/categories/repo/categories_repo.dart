import 'package:fpdart/fpdart.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/dto/add_categories_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/models/categories_model.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoriesModel>>> getCategories();

  Future<Either<Failure, String>> allocateCategory({
    required AddCategoriesDto addCategoriesDto,
  });

  Future<Either<Failure, String>> deleteCategory({
    required String categoryName,
  });
}
