// lib/modules/budgeting_app/features/auth/repo/auth_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/signup_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/repo/auth_repository.dart';
import 'package:lifesphere_essentials/service/firebase_auth_service/auth_service.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Either<Failure, UserModel>> signup(SignUpParams params) async {
    final result = await _authService.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    return result.fold(
      (failure) => Left(failure),
      (user) =>
          Right(UserModel(uid: user.uid, email: user.email ?? params.email)),
    );
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    return await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return await _authService.signOut();
  }

  @override
  Stream<UserModel?> get authStateChanges => _authService.authStateChanges;

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    return await _authService.getCurrentUser();
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    return await _authService.sendPasswordResetEmail(email);
  }
}
