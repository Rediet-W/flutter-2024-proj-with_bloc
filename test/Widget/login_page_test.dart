import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/auth/bloc/auth_bloc.dart';
import 'package:flutter_project/auth/bloc/auth_event.dart';
import 'package:flutter_project/auth/bloc/auth_state.dart';
import 'package:flutter_project/presentation/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    // Register fallback values to avoid unnecessary issues
    registerFallbackValue(LoginEvent(email: '', password: ''));
    registerFallbackValue(AuthInitial());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();

    // Provide a default stream
    when(() => mockAuthBloc.stream)
        .thenAnswer((_) => Stream<AuthState>.empty());
    // Provide a default state
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());
    // Mock the close method
    when(() => mockAuthBloc.close()).thenAnswer((_) => Future.value());
  });

  Widget createTestWidget() {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider.value(
            value: mockAuthBloc,
            child: LogInPage(),
          ),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) =>
              Scaffold(body: Center(child: Text('Home Page'))),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) =>
              Scaffold(body: Center(child: Text('Sign Up'))),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
    );
  }

  testWidgets('Login Page - displays and interacts correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    // Verify initial state
    expect(find.text('Log In'),
        findsNWidgets(2)); // Could be header and button text
    expect(find.byKey(Key('emailField')), findsOneWidget);
    expect(find.byKey(Key('passwordField')), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Enter valid email and password
    await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(Key('passwordField')), 'password123');

    // Tap on login button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that LoginEvent is added to AuthBloc
    verify(() => mockAuthBloc.add(
            LoginEvent(email: 'test@example.com', password: 'password123')))
        .called(1);
  });

  testWidgets('Login Page - shows error message on login failure',
      (WidgetTester tester) async {
    // Set up the mock stream to emit the error state
    whenListen(
      mockAuthBloc,
      Stream<AuthState>.fromIterable([AuthError('Login failed')]),
    );

    await tester.pumpWidget(createTestWidget());

    // Simulate error state
    mockAuthBloc.emit(AuthError('Login failed'));
    await tester.pump();

    // Verify that error message is displayed
    expect(find.text('Login failed'), findsOneWidget);
  });
}
