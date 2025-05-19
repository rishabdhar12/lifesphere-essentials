import 'package:equatable/equatable.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/dto/add_categories_dto.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent extends CategoriesEvent {
  GetCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class AllocateCategoriesEvent extends CategoriesEvent {
  final AddCategoriesDto addCategoriesDto;

  AllocateCategoriesEvent({required this.addCategoriesDto});

  @override
  List<Object?> get props => [addCategoriesDto];
}
