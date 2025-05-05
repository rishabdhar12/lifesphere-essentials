// lib/modules/budgeting_app/features/auth/data/services/auth_service_impl.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';
import 'package:lifesphere_essentials/service/firebase_auth_service/auth_service.dart';

@Injectable(as: AuthService)
class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthServiceImpl(this._firebaseAuth);

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      return user?.toUserModel();
    });
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      debugPrint('User: ${user?.uid}');

      if (user == null) {
        return Left(Failure('User creation failed'));
      }

      return Right(user.toUserModel());
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? 'Sign up failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        return Left(Failure('Sign in failed'));
      }

      return Right(user.toUserModel());
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? 'Sign in failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? 'Password reset failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return Right(user?.toUserModel());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

// Extension to convert Firebase User to your UserModel
extension on User {
  UserModel toUserModel() {
    return UserModel(
      uid: uid,
      email: email,
      displayName: displayName,
      photoURL: photoURL,
      emailVerified: emailVerified,
    );
  }
}
