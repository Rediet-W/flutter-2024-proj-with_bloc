import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import '../../secure_storage_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SecureStorageService _secureStorageService = SecureStorageService();

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

    on<LoadUserProfile>((event, emit) async {
      emit(ProfileLoading());

      try {
        final userId = await _secureStorageService.readUserId();
        final user = await authRepository.getUserProfile(userId);
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError('Failed to load profile: ${e.toString()}'));
        emit(ProfileInitial());
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

    on<UpdateUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final userId = await _secureStorageService.readUserId();
        final user =
            await authRepository.updateUserProfile(userId, event.password);
        emit(ProfileUpdated(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<DeleteUserProfile>((event, emit) async {
      emit(ProfileDeleting());

      try {
        final userId = await _secureStorageService.readUserId();
        await authRepository.deleteUserProfile(userId);
        debugPrint('Profile deleted');
        emit(ProfileDeleted());
      } catch (e) {
        debugPrint('Profile delete failed: $e');
        emit(ProfileError('Profile delete failed: ${e.toString()}'));
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
