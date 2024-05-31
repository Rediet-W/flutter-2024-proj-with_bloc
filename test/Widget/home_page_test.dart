import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/screens/create_post_page.dart';
import 'package:flutter_project/presentation/screens/profile.dart';
import 'package:flutter_project/presentation/screens/withaccount.dart';
import 'package:flutter_project/presentation/widgets/nav.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('shows initial page correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Initially, WithAccount should be displayed
      expect(find.byType(WithAccount), findsOneWidget);
      expect(find.byType(LostFoundForm), findsNothing);
      expect(find.byType(ProfileTwo), findsNothing);
    });

    testWidgets(
        'navigates to Add Post page when bottom navigation item is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Tap the add post icon
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(); // Ensure the UI has settled after the tap

      // After tapping the add post icon, LostFoundForm should be displayed
      expect(find.byType(LostFoundForm), findsOneWidget);
      expect(find.byType(WithAccount), findsNothing);
      expect(find.byType(ProfileTwo), findsNothing);
    });

    testWidgets(
        'navigates to Profile page when bottom navigation item is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Tap the profile icon
      await tester.tap(find.byIcon(Icons.account_box));
      await tester.pumpAndSettle(); // Ensure the UI has settled after the tap

      // After tapping the profile icon, ProfileTwo should be displayed
      expect(find.byType(ProfileTwo), findsOneWidget);
      expect(find.byType(WithAccount), findsNothing);
      expect(find.byType(LostFoundForm), findsNothing);
    });

    testWidgets(
        'navigates back to Home page when bottom navigation item is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Navigate to another page first
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.byType(LostFoundForm), findsOneWidget);

      // Now tap the home icon
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle(); // Ensure the UI has settled after the tap

      // Home page (WithAccount) should be displayed again
      expect(find.byType(WithAccount), findsOneWidget);
      expect(find.byType(LostFoundForm), findsNothing);
      expect(find.byType(ProfileTwo), findsNothing);
    });
  });
}
