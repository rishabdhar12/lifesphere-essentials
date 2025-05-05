// lib/modules/budgeting_app/features/auth/repo/auth_repository.dart
import 'package:fpdart/fpdart.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/signup_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signup(SignUpParams params);
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();
  Stream<UserModel?> get authStateChanges;
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
}
