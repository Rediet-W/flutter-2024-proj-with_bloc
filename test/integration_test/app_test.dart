import 'package:flutter_project/presentation/widgets/nav.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("User Flow Integration Test", () {
    testWidgets(
        "Full Flow: Signup -> Login -> Home -> Item Detail -> Comment -> Create Post -> Update Profile",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Sign Up
      await tester.tap(find.byKey(Key('signupButton')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('usernameField')), 'testuser');
      await tester.enterText(
          find.byKey(Key('emailField')), 'testuser@example.com');
      await tester.enterText(find.byKey(Key('passwordField')), 'password123');
      await tester.tap(find.byKey(Key('signUpButton')));
      await tester.pumpAndSettle();

      // Confirm navigation to home page after signup
      expect(find.byKey(Key('homeScreen')), findsOneWidget);

      // Navigate to Item Detail from Home
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Assume the home screen displays a list of items, tap on the first item
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      // Confirm navigation to item detail page
      expect(find.byKey(Key('itemDetail')), findsOneWidget);

      // Add a comment to the item
      await tester.enterText(find.byKey(Key('commentField')), 'Nice item!');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Confirm comment is added
      expect(find.text('Nice item!'), findsOneWidget);

      // Navigate to Create Post
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('titleField')), 'ID');
      await tester.enterText(find.byKey(Key('locationField')), 'Library');
      await tester.enterText(find.byKey(Key('timeField')), '10:00 AM');
      await tester.enterText(
          find.byKey(Key('descriptionField')), 'has a holder');

      // Submit the new post (skipping image)
      await tester.tap(find.byKey(Key('postButton')));
      await tester.pumpAndSettle();

      // Confirm post creation (e.g., success message or navigation)
      expect(find.text('Post created successfully.'), findsOneWidget);

      // Navigate to Profile and edit profile
      await tester.tap(find.byIcon(Icons.account_box));
      await tester.pumpAndSettle();

      // Edit profile fields
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Updated Name');
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      // Confirm profile update
      expect(find.text('Updated Name'), findsOneWidget);
    });

    testWidgets("Invalid Email Signup", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('signupButton')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('usernameField')), 'testuser');
      await tester.enterText(find.byKey(Key('emailField')), 'invalidEmail');
      await tester.enterText(find.byKey(Key('passwordField')), 'password123');
      await tester.tap(find.byKey(Key('signUpButton')));
      await tester.pumpAndSettle();

      // Confirm invalid email error
      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets("Login with Valid Credentials", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(Key('emailField')), 'testuser@example.com');
      await tester.enterText(find.byKey(Key('passwordField')), 'password123');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      // Confirm navigation to home after login
      expect(find.byKey(Key('homeScreen')), findsOneWidget);
    });

    testWidgets("Login with Invalid Credentials", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(Key('emailField')), 'wronguser@example.com');
      await tester.enterText(find.byKey(Key('passwordField')), 'wrongpassword');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      // Confirm error message
      expect(find.text('Invalid credentials: Login failed'), findsOneWidget);
    });

    testWidgets("Navigate to Signup from Login", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('I do not have an account'));
      await tester.pumpAndSettle();

      // Confirm navigation to signup page
      expect(find.byKey(Key('signUpScreen')), findsOneWidget);
    });

    testWidgets("Create Post with Incomplete Data",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('titleField')), 'Incomplete Post');
      // Leave other fields empty

      await tester.tap(find.byKey(Key('postButton')));
      await tester.pumpAndSettle();

      // Confirm error message for incomplete form
      expect(find.text('Please fill in all fields and attach an image.'),
          findsOneWidget);
    });

    testWidgets("Edit Profile Successfully", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Log in first
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(Key('emailField')), 'testuser@example.com');
      await tester.enterText(find.byKey(Key('passwordField')), 'password123');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.account_box));
      await tester.pumpAndSettle();
    });
  });
}
