// lib/modules/budgeting_app/features/auth/data/services/auth_service.dart
import 'package:fpdart/fpdart.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';

abstract class AuthService {
  Stream<UserModel?> get authStateChanges;

  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  Future<Either<Failure, UserModel?>> getCurrentUser();
}
