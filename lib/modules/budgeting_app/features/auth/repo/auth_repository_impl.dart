// lib/modules/budgeting_app/features/auth/repo/auth_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/login_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/signup_dto.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/repo/auth_repository.dart';
import 'package:lifesphere_essentials/service/firebase_auth_service/auth_service.dart';
import 'package:lifesphere_essentials/service/firestore_service/firestore_service.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final _authService = getIt<AuthService>();
  final _firestoreService = getIt<FirestoreService>();

  AuthRepositoryImpl();

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
  Future<Either<Failure, UserModel>> login(LoginParams loginParams) async {
    return await _authService.signInWithEmailAndPassword(
      email: loginParams.email,
      password: loginParams.password,
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

  @override
  Future<Either<Failure, void>> createAuthDocument({
    required String email,
    required String uid,
  }) {
    return _firestoreService.createDocument(
      collectionPath: 'users',
      docId: uid,
      data: {'email': email, 'uid': uid, 'createdAt': DateTime.now()},
    );
  }
}
