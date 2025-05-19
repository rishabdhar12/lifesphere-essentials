import 'package:equatable/equatable.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/models/categories_model.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesFinishedState extends CategoriesState {
  final List<CategoriesModel> categories;

  CategoriesFinishedState({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CategoriesAllocatedState extends CategoriesState {
  final String message;

  CategoriesAllocatedState({required this.message});

  @override
  List<Object?> get props => [message];
}


// TODO: category delete state