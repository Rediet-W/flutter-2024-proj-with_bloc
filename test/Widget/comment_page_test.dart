import 'package:flutter/material.dart';
import 'package:flutter_project/comment/bloc/comment_bloc.dart';
import 'package:flutter_project/comment/bloc/comment_state.dart';
import 'package:flutter_project/comment/model/comment.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_project/presentation/screens/comment_page.dart';

// Mock classes
class MockCommentBloc extends Mock implements CommentBloc {}

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late CommentBloc mockCommentBloc;
  late CommentRepository mockCommentRepository;

  setUp(() {
    // Initialize mock dependencies
    mockCommentBloc = MockCommentBloc();
    mockCommentRepository = MockCommentRepository();

    // Setup default mock behavior
    when(() => mockCommentBloc.state).thenReturn(CommentInitial());
    when(() => mockCommentBloc.stream)
        .thenAnswer((_) => Stream<CommentState>.empty());
  });

  Widget createTestWidget() {
    return MultiProvider(
      providers: [
        Provider<CommentRepository>.value(value: mockCommentRepository),
        BlocProvider<CommentBloc>.value(value: mockCommentBloc),
      ],
      child: MaterialApp(
        home: CommentPage(postId: 'testPostId'),
      ),
    );
  }

  group('CommentPage Widget Tests', () {
    testWidgets('renders CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      when(() => mockCommentBloc.state).thenReturn(CommentsLoading());

      await tester.pumpWidget(createTestWidget());
      await tester.pump(); // Apply state

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders ListView when comments are loaded',
        (WidgetTester tester) async {
      final comments = [
        Comment(id: '1', userId: '1', content: 'First comment'),
        Comment(id: '2', userId: '2', content: 'Second comment'),
      ];

      when(() => mockCommentBloc.state).thenReturn(CommentsLoaded(comments));

      await tester.pumpWidget(createTestWidget());
      await tester.pump(); // Apply state

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('renders "No comments found" when no comments are present',
        (WidgetTester tester) async {
      when(() => mockCommentBloc.state).thenReturn(CommentsLoaded([]));

      await tester.pumpWidget(createTestWidget());
      await tester.pump(); // Apply state

      expect(find.text('No comments found'), findsOneWidget);
    });

    testWidgets('renders error message on loading error',
        (WidgetTester tester) async {
      when(() => mockCommentBloc.state)
          .thenReturn(CommentError('Error loading comments'));

      await tester.pumpWidget(createTestWidget());
      await tester.pump(); // Apply state

      expect(find.text('Error loading comments'), findsOneWidget);
    });

    testWidgets('renders "Add Comment" button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump(); // Apply state

      expect(find.text('Add Comment'), findsOneWidget);
    });
  });
}
