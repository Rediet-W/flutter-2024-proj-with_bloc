import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_project/post/provider/post_provider.dart';

// Mock class for http.Client
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('PostProvider tests', () {
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
    });

    testWidgets('PostProvider provides PostRepository',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<http.Client>.value(value: mockHttpClient),
          ],
          child: PostProvider(
            child: Builder(
              builder: (context) {
                final postRepository =
                    RepositoryProvider.of<PostRepository>(context);
                expect(postRepository, isNotNull);
                return const Placeholder();
              },
            ),
          ),
        ),
      );
    });
  });
}
