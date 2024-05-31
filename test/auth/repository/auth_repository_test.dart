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
  late MockClient mockHttpClient;
  late MockSecureStorageService mockSecureStorageService;

  setUp(() {
    mockHttpClient = MockClient();
    mockSecureStorageService = MockSecureStorageService();
    authRepository = AuthRepository(
      httpClient: mockHttpClient,
      secureStorageService: mockSecureStorageService,
      baseUrl: 'http://localhost:3003/auth',
    );
  });

  group('AuthRepository', () {
    const baseUrl = 'http://localhost:3003/auth';
    const email = 'test@test.com';
    const password = 'password';
    const token = 'testToken';
    const userJson = {
      'id': '1',
      'email': email,
      'username': 'test_user',
      'token': token,
    };

    group('login', () {
      test('returns a User if the login call completes successfully', () async {
        // Arrange
        when(mockHttpClient.post(
          Uri.parse('$baseUrl/login'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(userJson), 200));

        when(mockSecureStorageService.writeToken(token))
            .thenAnswer((_) async => null);

        // Act
        final user = await authRepository.login(email, password);

        // Assert
        expect(user, isA<User>());
        expect(user.email, email);
        verify(mockSecureStorageService.writeToken(token)).called(1);
      });

      test('throws an exception if the login call completes with an error',
          () async {
        // Arrange
        when(mockHttpClient.post(
          Uri.parse('$baseUrl/login'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('Unauthorized', 401));

        // Act & Assert
        expect(() => authRepository.login(email, password),
            throwsA(isA<Exception>()));
      });
    });

    group('signup', () {
      const username = 'test_user';

      test('returns a User if the signup call completes successfully',
          () async {
        // Arrange
        when(mockHttpClient.post(
          Uri.parse('$baseUrl/signup'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(userJson), 200));

        when(mockSecureStorageService.writeToken(token))
            .thenAnswer((_) async => null);

        // Act
        final user = await authRepository.signup(username, email, password);

        // Assert
        expect(user, isA<User>());
        expect(user.email, email);
        verify(mockSecureStorageService.writeToken(token)).called(1);
      });

      test('throws an exception if the signup call completes with an error',
          () async {
        // Arrange
        when(mockHttpClient.post(
          Uri.parse('$baseUrl/signup'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('Bad Request', 400));

        // Act & Assert
        expect(() => authRepository.signup(username, email, password),
            throwsA(isA<Exception>()));
      });
    });

    group('logout', () {
      test('deletes the token if the logout call completes successfully',
          () async {
        // Arrange
        when(mockSecureStorageService.readToken())
            .thenAnswer((_) async => token);

        when(mockHttpClient.post(
          Uri.parse('$baseUrl/logout'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response('OK', 200));

        when(mockSecureStorageService.deleteToken())
            .thenAnswer((_) async => null);

        // Act
        await authRepository.logout();

        // Assert
        verify(mockSecureStorageService.deleteToken()).called(1);
      });

      test('throws an exception if the logout call completes with an error',
          () async {
        // Arrange
        when(mockSecureStorageService.readToken())
            .thenAnswer((_) async => token);

        when(mockHttpClient.post(
          Uri.parse('$baseUrl/logout'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response('Unauthorized', 401));

        // Act & Assert
        expect(() => authRepository.logout(), throwsA(isA<Exception>()));
      });
    });

    group('getUserDetails', () {
      test('returns a User if the getUserDetails call completes successfully',
          () async {
        // Arrange
        when(mockSecureStorageService.readToken())
            .thenAnswer((_) async => token);

        when(mockHttpClient.get(
          Uri.parse('$baseUrl/user/details'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(userJson), 200));

        // Act
        final user = await authRepository.getUserDetails();

        // Assert
        expect(user, isA<User>());
        expect(user.email, email);
      });

      test(
          'throws an exception if the getUserDetails call completes with an error',
          () async {
        // Arrange
        when(mockSecureStorageService.readToken())
            .thenAnswer((_) async => token);

        when(mockHttpClient.get(
          Uri.parse('$baseUrl/user/details'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(
            () => authRepository.getUserDetails(), throwsA(isA<Exception>()));
      });
    });
  });
}
