import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/blocs/auth_event.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/blocs/auth_state.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/repo/auth_repository.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<CheckUserExistEvent>(_onCheckUserExist);
    on<SignUpEvent>(_onSignUp);
    // on<GoogleSignInEvent>(_googleSignIn);
  }

  void _onCheckUserExist(
    CheckUserExistEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final failureOrUser = await authRepository.getCurrentUser();
    failureOrUser.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(UserExistState(user: user!)),
    );
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final signUpResponse = await authRepository.signup(event.signUpParams);
      signUpResponse.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(SignUpFinishedState(user: user)),
      );
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }
}
