import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/auth/model/user.dart';
import 'package:flutter_project/auth/repository/auth_repository.dart';
import 'package:flutter_project/secure_storage_service.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([http.Client, SecureStorageService])
void main() {
  late AuthRepository authRepository;
  late MockSecureStorageService mockSecureStorageService;
  late MockClient mockHttpClient;

  setUp(() {
    mockSecureStorageService = MockSecureStorageService();
    mockHttpClient = MockClient();
    authRepository = AuthRepository(
      baseUrl: 'http://localhost:3003/auth',
      secureStorageService: mockSecureStorageService,
    );
  });

  group('AuthRepository', () {
    const email = 'test@test.com';
    const password = 'password';
    const username = 'test_user';
    const token = 'testToken';
    const userId = '1';
    const roles = ['user'];
    final userJson = {
      'id': userId,
      'email': email,
      'username': username,
      'token': token,
      'roles': roles,
    };

    group('login', () {
      test('returns a User if the login call completes successfully', () async {
        // Arrange
        final headers = {'Content-Type': 'application/json; charset=UTF-8'};
        final body = jsonEncode({'email': email, 'password': password});

        when(mockHttpClient.post(
          Uri.parse('http://localhost:3003/auth/login'),
          headers: headers,
          body: body,
        )).thenAnswer((_) async => http.Response(jsonEncode(userJson), 200));

        // Mock SecureStorageService
        when(mockSecureStorageService.writeTokenRolesAndUserId(
          token,
          roles,
          userId,
        )).thenAnswer((_) => Future<void>.value());

        // Act
        final user =
            await authRepository.login(email, password, client: mockHttpClient);

        // Assert
        expect(user, isA<User>());
        expect(user.email, email);
        expect(user.roles, roles);
        verify(mockSecureStorageService.writeTokenRolesAndUserId(
          token,
          roles,
          userId,
        )).called(1);
      });

      test('throws an exception if the login call completes with an error',
          () async {
        // Arrange
        final headers = {'Content-Type': 'application/json; charset=UTF-8'};
        final body = jsonEncode({'email': email, 'password': password});

        when(mockHttpClient.post(
          Uri.parse('http://localhost:3003/auth/login'),
          headers: headers,
          body: body,
        )).thenAnswer((_) async => http.Response('Unauthorized', 401));

        // Act & Assert
        expect(
            () => authRepository.login(email, password, client: mockHttpClient),
            throwsA(isA<Exception>()));
      });
    });

    group('signup', () {
      test('returns a User if the signup call completes successfully',
          () async {
        // Arrange
        final headers = {'Content-Type': 'application/json; charset=UTF-8'};
        final body = jsonEncode(
            {'fullname': username, 'email': email, 'password': password});

        when(mockHttpClient.post(
          Uri.parse('http://localhost:3003/auth/signup'),
          headers: headers,
          body: body,
        )).thenAnswer((_) async => http.Response(jsonEncode(userJson), 201));

        // Mock SecureStorageService
        when(mockSecureStorageService.writeTokenRolesAndUserId(
          token,
          roles,
          userId,
        )).thenAnswer((_) => Future<void>.value());

        // Act
        final user = await authRepository.signup(username, email, password,
            client: mockHttpClient);

        // Assert
        expect(user, isA<User>());
        expect(user.email, email);
        expect(user.roles, roles);
        verify(mockSecureStorageService.writeTokenRolesAndUserId(
          token,
          roles,
          userId,
        )).called(1);
      });

      test('throws an exception if the signup call completes with an error',
          () async {
        // Arrange
        final headers = {'Content-Type': 'application/json; charset=UTF-8'};
        final body = jsonEncode(
            {'fullname': username, 'email': email, 'password': password});

        when(mockHttpClient.post(
          Uri.parse('http://localhost:3003/auth/signup'),
          headers: headers,
          body: body,
        )).thenAnswer((_) async => http.Response('Bad Request', 400));

        // Act & Assert
        expect(
            () => authRepository.signup(username, email, password,
                client: mockHttpClient),
            throwsA(isA<Exception>()));
      });
    });

    group('logout', () {
      test(
          'deletes the token, roles, and userId if the logout call completes successfully',
          () async {
        // Arrange
        when(mockSecureStorageService.deleteTokenRolesAndUserId())
            .thenAnswer((_) => Future<void>.value());

        // Act
        await authRepository.logout();

        // Assert
        verify(mockSecureStorageService.deleteTokenRolesAndUserId()).called(1);
      });

      test('throws an exception if the logout call completes with an error',
          () async {
        // Arrange
        when(mockSecureStorageService.deleteTokenRolesAndUserId())
            .thenThrow(Exception('Logout failed'));

        // Act & Assert
        expect(() => authRepository.logout(), throwsA(isA<Exception>()));
      });
    });
  });
}
