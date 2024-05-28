import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await authRepository.login(event.email, event.password);
        emit(AuthLoggedIn(user));
      } catch (e) {
        emit(const AuthError('Login failed'));
        emit(AuthInitial());
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await authRepository.signup(
            event.username, event.email, event.password);
        emit(AuthLoggedIn(user));
      } catch (e) {
        emit(const AuthError('Signup failed'));
        emit(AuthInitial());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await authRepository.logout();
        emit(AuthLoggedOut());
      } catch (e) {
        emit(const AuthError('Logout failed'));
      }
    });
  }
}
