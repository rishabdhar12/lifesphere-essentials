import 'package:equatable/equatable.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthenticatedState extends AuthState {
  final UserModel user;

  AuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

class SignUpFinishedState extends AuthState {
  final UserModel user;

  SignUpFinishedState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserExistState extends AuthState {
  final UserModel user;

  UserExistState({required this.user});

  @override
  List<Object> get props => [user];
}

// class GoogleAuthenticatedState extends AuthState {
//   final GoogleUserEntity user;

//   GoogleAuthenticatedState({required this.user});

//   @override
//   List<Object> get props => [user];
// }
