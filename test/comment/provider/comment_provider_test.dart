import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/comment/provider/comment_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        Uri.parse('http://example.com')); // Register fallback value
  });

  group('CommentProvider', () {
    late CommentProvider commentProvider;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      commentProvider = CommentProvider(child: Container());
      commentProvider.commentRepository = CommentRepository(
        baseUrl: 'http://10.0.2.2:3003/',
      );
    });

    tearDown(() {
      // Dispose resources
    });

    group('build', () {
      testWidgets('provides CommentRepository to its descendants',
          (tester) async {
        // Build CommentProvider widget
        await tester.pumpWidget(
          CommentProvider(child: Builder(
            builder: (context) {
              final commentRepository =
                  RepositoryProvider.of<CommentRepository>(context);
              expect(commentRepository, isA<CommentRepository>());
              return Container();
            },
          )),
        );
      });
    });
  });
}
