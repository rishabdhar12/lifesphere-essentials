import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/blocs/auth_bloc.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_bloc.dart';

var blocProviders = [
  BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
  BlocProvider<CategoriesBloc>(create: (context) => getIt<CategoriesBloc>()),
];
