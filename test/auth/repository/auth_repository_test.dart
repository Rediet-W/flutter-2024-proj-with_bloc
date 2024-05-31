// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/testing.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_project/auth/repository/auth_repository.dart';
// import 'package:flutter_project/auth/model/user.dart';
// import 'package:flutter_project/secure_storage_service.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'auth_repository_test.mocks.dart';

// @GenerateMocks([SecureStorageService])
// void main() {
//   late AuthRepository authRepository;
//   late MockSecureStorageService mockSecureStorageService;

//   setUp(() {
//     mockSecureStorageService = MockSecureStorageService();
//     // Initialize AuthRepository without changing the original constructor
//     authRepository = AuthRepository();
//   });

//   test('login returns a User if the http call completes successfully',
//       () async {
//     // Use MockClient to simulate the HTTP response
//     final mockClient = MockClient((request) async {
//       if (request.method == 'POST' && request.url.path == '/auth/login') {
//         return http.Response(
//             jsonEncode({
//               "id": "user123",
//               "email": "test@example.com",
//               "fullname": "Test User",
//               "roles": ["user"],
//               "token": "fake-token"
//             }),
//             200);
//       }
//       return http.Response('Not Found', 404);
//     });

//     // Inject MockClient into AuthRepository for testing purposes
//     authRepository = AuthRepository(
//       client: mockClient,
//       secureStorageService: mockSecureStorageService,
//     );

//     final user = await authRepository.login('test@example.com', 'password');
//     expect(user.id, 'user123');
//     expect(user.email, 'test@example.com');
//   });

//   test('signup returns a User if the http call completes successfully',
//       () async {
//     final mockClient = MockClient((request) async {
//       if (request.method == 'POST' && request.url.path == '/auth/signup') {
//         return http.Response(
//             jsonEncode({
//               "id": "user123",
//               "email": "test@example.com",
//               "fullname": "Test User",
//               "roles": ["user"],
//               "token": "fake-token"
//             }),
//             201);
//       }
//       return http.Response('Not Found', 404);
//     });

//     // Inject MockClient into AuthRepository for testing purposes
//     authRepository = AuthRepository(
//       client: mockClient,
//       secureStorageService: mockSecureStorageService,
//     );

//     final user = await authRepository.signup(
//         'Test User', 'test@example.com', 'password');
//     expect(user.id, 'user123');
//     expect(user.email, 'test@example.com');
//   });

//   // Add more tests as needed for logout, getUserProfile, updateUserProfile, deleteUserProfile
// }
