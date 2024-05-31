import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_project/auth/repository/auth_repository.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/comment/bloc/comment_bloc.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_project/auth/bloc/auth_bloc.dart';
import 'package:flutter_project/main.dart'; // Import your main file
import 'package:flutter_project/router.dart'; // Import your router file

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockCommentRepository extends Mock implements CommentRepository {}

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  testWidgets('MyApp initializes properly', (WidgetTester tester) async {
    // Create the mock repositories
    final mockAuthRepository = MockAuthRepository();
    final mockCommentRepository = MockCommentRepository();
    final mockPostRepository = MockPostRepository();

    // Provide the repositories using MultiRepositoryProvider
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>.value(value: mockAuthRepository),
          RepositoryProvider<CommentRepository>.value(
              value: mockCommentRepository),
          RepositoryProvider<PostRepository>.value(value: mockPostRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                authRepository: mockAuthRepository,
              ),
            ),
            BlocProvider<CommentBloc>(
              create: (context) => CommentBloc(
                commentRepository: mockCommentRepository,
              ),
            ),
            BlocProvider<PostBloc>(
              create: (context) => PostBloc(
                postRepository: mockPostRepository,
              ),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: router, // Use the GoRouter configuration
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          ),
        ),
      ),
    );

    // Verify that the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
