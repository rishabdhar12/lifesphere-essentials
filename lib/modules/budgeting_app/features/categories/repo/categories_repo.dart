import 'package:fpdart/fpdart.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/models/categories_model.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoriesModel>>> getCategories();
}
