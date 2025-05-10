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
    on<LoginEvent>(_onLogin);
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

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final signUpResult = await authRepository.signup(event.signUpParams);

      if (signUpResult.isLeft()) {
        final failure = signUpResult.fold((l) => l, (r) => null);
        emit(AuthError(message: failure?.message ?? 'Unknown sign-up error'));
        return;
      }

      final user = signUpResult.fold((failure) {
        emit(AuthError(message: failure.message));
        return null;
      }, (user) => user);

      if (user == null) return;

      final createDocResult = await authRepository.createAuthDocument(
        email: event.signUpParams.email,
        uid: user.uid,
      );

      if (createDocResult.isLeft()) {
        final failure = createDocResult.fold((l) => l, (r) => null);
        emit(AuthError(message: failure?.message ?? 'Unknown document error'));
        return;
      }

      emit(SignUpFinishedState(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final loginResponse = await authRepository.login(event.loginParams);
      loginResponse.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(LoginFinishedState(user: user)),
      );
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }
}
