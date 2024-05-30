import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await authRepository.login(event.email, event.password);
        debugPrint('Login successful: $user');
        emit(AuthLoggedIn(user));
      } catch (e) {
        debugPrint('Login failed: $e');
        emit(AuthError('Login failed: ${e.toString()}'));
        emit(AuthInitial());
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await authRepository.signup(
            event.username, event.email, event.password);
        debugPrint('Signup successful: $user');
        emit(AuthLoggedIn(user));
      } catch (e) {
        debugPrint('Signup failed: $e');
        emit(AuthError('Signup failed: ${e.toString()}'));
        emit(AuthInitial());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await authRepository.logout();
        debugPrint('Logout successful');
        emit(AuthLoggedOut());
      } catch (e) {
        debugPrint('Logout failed: $e');
        emit(AuthError('Logout failed: ${e.toString()}'));
      }
    });
  }
}
