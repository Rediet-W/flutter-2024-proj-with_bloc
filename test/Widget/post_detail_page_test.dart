import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/screens/create_post_page.dart';
import 'package:flutter_test/flutter_test.dart'; // Replace with actual import

void main() {
  group('LostFoundForm Widget Tests', () {
    testWidgets('renders all input fields and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LostFoundForm()));

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets(
        'shows validation message when trying to post with empty fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LostFoundForm()));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Please fill in all fields and attach an image.'),
          findsOneWidget);
    });

    testWidgets('picks an image when Attach Image button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LostFoundForm()));

      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();

      // Since we cannot pick an image in a test environment, we simulate the action by setting an image manually
      // The following action should be handled in the widget's state when actually picked
      final _LostFoundFormState state =
          tester.state(find.byType(LostFoundForm));
      state.setState(() {
        state._selectedImage = Uint8List.fromList(
            [0, 1, 2, 3]); // Simulate an image being selected
      });

      await tester.pump();

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('creates post successfully with valid inputs',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LostFoundForm()));

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Title'), 'Lost Wallet');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Location'), 'City Park');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Time'), '2 PM');
      await tester.enterText(find.widgetWithText(TextFormField, 'Description'),
          'A black leather wallet.');

      // Simulate image selection
      final _LostFoundFormState state =
          tester.state(find.byType(LostFoundForm));
      state.setState(() {
        state._selectedImage = Uint8List.fromList(
            [0, 1, 2, 3]); // Simulate an image being selected
      });

      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Since we can't actually send a network request in a test, we assume it will show a success message
      expect(find.text('Post created successfully.'), findsOneWidget);
    });
  });
}
