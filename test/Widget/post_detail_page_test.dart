// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest(String postId, Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('ItemPage shows loading indicator when loading',
      (WidgetTester tester) async {
    // Create a loading state widget
    Widget loadingWidget = Builder(
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    await tester.pumpWidget(createWidgetUnderTest('1', loadingWidget));

    // Verify that the CircularProgressIndicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ItemPage shows error message when there is an error',
      (WidgetTester tester) async {
    // Create an error state widget
    Widget errorWidget = Builder(
      builder: (context) => Center(child: Text('Failed to load post details')),
    );

    await tester.pumpWidget(createWidgetUnderTest('1', errorWidget));

    // Verify that the error message is shown
    expect(find.text('Failed to load post details'), findsOneWidget);
  });
}
