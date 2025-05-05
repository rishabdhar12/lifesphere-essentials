import 'package:equatable/equatable.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/signup_dto.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GoogleSignInEvent extends AuthEvent {
  GoogleSignInEvent();

  @override
  List<Object> get props => [];
}

class CheckUserExistEvent extends AuthEvent {
  final String email;

  CheckUserExistEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class SignUpEvent extends AuthEvent {
  final SignUpParams signUpParams;

  SignUpEvent({required this.signUpParams});

  @override
  List<Object> get props => [signUpParams];
}
