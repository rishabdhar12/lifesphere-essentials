// lib/modules/budgeting_app/features/auth/repo/auth_repository.dart
import 'package:fpdart/fpdart.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/login_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/signup_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signup(SignUpParams params);
  Future<Either<Failure, UserModel>> login(LoginParams loginParams);
  Future<Either<Failure, void>> logout();
  Stream<UserModel?> get authStateChanges;
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, void>> createAuthDocument({
    required String email,
    required String uid,
  });
}
