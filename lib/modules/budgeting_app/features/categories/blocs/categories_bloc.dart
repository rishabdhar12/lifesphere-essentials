import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_event.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_state.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/repo/categories_repo.dart';

@Injectable()
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepo categoriesRepo;

  CategoriesBloc({required this.categoriesRepo}) : super(CategoriesInitial()) {
    on<GetCategoriesEvent>(_onFetchCategories);
    on<AllocateCategoriesEvent>(_onAddCategories);
  }

  void _onFetchCategories(
    GetCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    final failureOrCategories = await categoriesRepo.getCategories();
    failureOrCategories.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (categories) => emit(CategoriesFinishedState(categories: categories)),
    );
  }

  void _onAddCategories(
    AllocateCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    // emit(CategoriesLoading());
    final failureOrCategories = await categoriesRepo.allocateCategory(
      addCategoriesDto: event.addCategoriesDto,
    );
    failureOrCategories.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (message) {
        emit(CategoriesAllocatedState(message: message));
        add(GetCategoriesEvent());
        log(message);
      },
    );
  }
}
