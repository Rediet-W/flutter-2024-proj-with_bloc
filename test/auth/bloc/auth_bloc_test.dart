import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_project/auth/bloc/auth_bloc.dart';
import 'package:flutter_project/auth/bloc/auth_event.dart';
import 'package:flutter_project/auth/bloc/auth_state.dart';
import 'package:flutter_project/auth/model/user.dart';
import 'package:flutter_project/auth/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

// Generate mock classes using Mockito
@GenerateMocks([AuthRepository])
void main() {
  group('AuthBloc', () {
    late MockAuthRepository mockAuthRepository;
    late AuthBloc authBloc;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc(authRepository: mockAuthRepository);
    });

    tearDown(() {
      authBloc.close();
    });

    group('LoginEvent', () {
      const String testEmail = 'test@example.com';
      const String testPassword = 'testpassword';
      User testUser = User(id: '1', email: testEmail, username: 'testuser');

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthLoggedIn] when login is successful',
        build: () {
          when(mockAuthRepository.login(testEmail, testPassword))
              .thenAnswer((_) async => testUser);
          return authBloc;
        },
        act: (bloc) => bloc
            .add(const LoginEvent(email: testEmail, password: testPassword)),
        expect: () => [
          AuthLoading(),
          AuthLoggedIn(testUser),
        ],
        verify: (_) {
          verify(mockAuthRepository.login(testEmail, testPassword)).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError, AuthInitial] when login fails',
        build: () {
          when(mockAuthRepository.login(testEmail, testPassword))
              .thenThrow(Exception('Login failed'));
          return authBloc;
        },
        act: (bloc) => bloc
            .add(const LoginEvent(email: testEmail, password: testPassword)),
        expect: () => [
          AuthLoading(),
          const AuthError('Login failed'),
          AuthInitial(),
        ],
      );
    });

    group('SignupEvent', () {
      const String testUsername = 'testuser';
      const String testEmail = 'test@example.com';
      const String testPassword = 'testpassword';
      User testUser = User(id: '1', email: testEmail, username: testUsername);

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthLoggedIn] when signup is successful',
        build: () {
          when(mockAuthRepository.signup(testUsername, testEmail, testPassword))
              .thenAnswer((_) async => testUser);
          return authBloc;
        },
        act: (bloc) => bloc.add(const SignupEvent(
            username: testUsername, email: testEmail, password: testPassword)),
        expect: () => [
          AuthLoading(),
          AuthLoggedIn(testUser),
        ],
        verify: (_) {
          verify(mockAuthRepository.signup(
                  testUsername, testEmail, testPassword))
              .called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError, AuthInitial] when signup fails',
        build: () {
          when(mockAuthRepository.signup(testUsername, testEmail, testPassword))
              .thenThrow(Exception('Signup failed'));
          return authBloc;
        },
        act: (bloc) => bloc.add(const SignupEvent(
            username: testUsername, email: testEmail, password: testPassword)),
        expect: () => [
          AuthLoading(),
          const AuthError('Signup failed'),
          AuthInitial(),
        ],
      );
    });
    group('LogoutEvent', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthLoggedOut] when logout is successful',
        build: () {
          when(mockAuthRepository.logout())
              .thenAnswer((_) async => Future.value());
          return authBloc;
        },
        act: (bloc) => bloc.add(LogoutEvent()),
        expect: () => [
          AuthLoading(),
          AuthLoggedOut(),
        ],
        verify: (_) {
          verify(mockAuthRepository.logout()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when logout fails',
        build: () {
          when(mockAuthRepository.logout())
              .thenThrow(Exception('Logout failed'));
          return authBloc;
        },
        act: (bloc) => bloc.add(LogoutEvent()),
        expect: () => [
          AuthLoading(),
          const AuthError('Logout failed'),
        ],
      );
    });
  });
}
