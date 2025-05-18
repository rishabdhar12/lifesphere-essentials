import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent extends CategoriesEvent {
  GetCategoriesEvent();

  @override
  List<Object?> get props => [];
}
