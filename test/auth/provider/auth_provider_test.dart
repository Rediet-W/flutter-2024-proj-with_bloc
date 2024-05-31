import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/auth/repository/auth_repository.dart';
import 'package:flutter_project/auth/provider/auth_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/secure_storage_service.dart';

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('AuthProvider tests', () {
    late MockSecureStorageService mockSecureStorageService;
    setUp(() {
      mockSecureStorageService = MockSecureStorageService();
    });

    testWidgets('AuthProvider provides AuthRepository',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<SecureStorageService>.value(
                value: mockSecureStorageService),
          ],
          child: AuthProvider(
            child: Builder(
              builder: (context) {
                final authRepository = context.read<AuthRepository>();
                expect(authRepository, isNotNull);
                return const Placeholder();
              },
            ),
          ),
        ),
      );
    });
  });
}
