import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/blocs/auth_bloc.dart';

var blocProviders = [BlocProvider(create: (context) => getIt<AuthBloc>())];
