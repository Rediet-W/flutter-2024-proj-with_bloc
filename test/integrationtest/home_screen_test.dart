import 'package:flutter_project/auth/repository/auth_repository.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_project/presentation/widgets/nav.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/presentation/screens/create_post_page.dart';
import 'package:flutter_project/presentation/screens/profile.dart';
import 'package:flutter_project/presentation/screens/withaccount.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test HomeScreen navigation and LostFoundForm interaction',
      (WidgetTester tester) async {
    // For example, you could use `mockito` or `http_mock_adapter` to mock responses

    // Start the app
    await tester.pumpWidget(MyApp(
      authRepository: AuthRepository(),
      commentRepository: CommentRepository(baseUrl: 'http://localhost:3003'),
      postRepository: PostRepository(baseUrl: 'http://localhost:3003/'),
    ));

    // Verify initial state
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(WithAccount), findsOneWidget);

    // Navigate to add post screen
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that LostFoundForm is displayed
    expect(find.byType(LostFoundForm), findsOneWidget);

    // Fill in the form fields
    await tester.enterText(find.byType(TextFormField).at(0), 'Title');
    await tester.enterText(find.byType(TextFormField).at(1), 'Location');
    await tester.enterText(find.byType(TextFormField).at(2), 'Time');
    await tester.enterText(find.byType(TextFormField).at(3), 'Description');

    // Simulate image attachment
    await tester.tap(find.byType(OutlinedButton));
    // Normally you'd mock the image picker result, but here we skip actual image selection
    await tester.pumpAndSettle();

    // Post the item
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify success message
    expect(find.text('Post created successfully.'), findsOneWidget);

    // Navigate to profile screen
    await tester.tap(find.byIcon(Icons.account_box));
    await tester.pumpAndSettle();

    // Verify ProfileTwo is displayed
    expect(find.byType(ProfileTwo), findsOneWidget);

    // Navigate back to home screen
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();

    // Verify WithAccount is displayed again
    expect(find.byType(WithAccount), findsOneWidget);
  });
}
