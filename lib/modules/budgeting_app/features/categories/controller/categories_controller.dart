import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_bloc.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_event.dart';
import 'package:lifesphere_essentials/router.dart';

class CategoriesController {
  List<String> categoryNames = [];

  void getCategories() {
    rootNavigatorKey.currentState!.context.read<CategoriesBloc>().add(
      GetCategoriesEvent(),
    );
  }

  void addOrRemoveCategories(String categoryName) {
    if (!categoryNames.contains(categoryName)) {
      categoryNames.add(categoryName);
    } else {
      categoryNames.remove(categoryName);
    }

    log("Categories: $categoryNames");
  }
}
