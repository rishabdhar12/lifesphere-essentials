// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/config/firebase/firebase_module.dart' as _i1067;
import '../modules/budgeting_app/features/auth/blocs/auth_bloc.dart' as _i680;
import '../modules/budgeting_app/features/auth/repo/auth_repository.dart'
    as _i637;
import '../modules/budgeting_app/features/auth/repo/auth_repository_impl.dart'
    as _i178;
import '../service/firebase_auth_service/auth_service.dart' as _i376;
import '../service/firebase_auth_service/auth_service_impl.dart' as _i359;
import '../service/firestore_service/firestore_service.dart' as _i590;
import '../service/firestore_service/firestore_service_impl.dart' as _i642;
import '../service/hive_service/hive_service.dart' as _i686;
import '../service/hive_service/hive_service_impl.dart' as _i349;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseModule = _$FirebaseModule();
  gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
  gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i686.HiveService<dynamic>>(
      () => _i349.HiveServiceImpl<dynamic>());
  gh.factory<_i590.FirestoreService>(
      () => _i642.FirestoreServiceImpl(gh<_i974.FirebaseFirestore>()));
  gh.factory<_i376.AuthService>(
      () => _i359.AuthServiceImpl(gh<_i59.FirebaseAuth>()));
  gh.factory<_i637.AuthRepository>(() => _i178.AuthRepositoryImpl(
        gh<_i376.AuthService>(),
        gh<_i590.FirestoreService>(),
      ));
  gh.factory<_i680.AuthBloc>(
      () => _i680.AuthBloc(authRepository: gh<_i637.AuthRepository>()));
  return getIt;
}

class _$FirebaseModule extends _i1067.FirebaseModule {}
