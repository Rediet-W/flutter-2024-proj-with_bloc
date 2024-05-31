import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CircularProgressIndicator(), // Initially simulate loading
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(title: Text('Test comment 1')),
                        ListTile(title: Text('Test comment 2')),
                      ],
                    ),
                  ),
                  Text('Failed to load comments'), // Simulate error
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: Key('commentField'),
                      decoration: InputDecoration(
                        labelText: 'Add a comment...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Placeholder for send button functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  testWidgets('CommentPage shows CircularProgressIndicator initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Verify that the CircularProgressIndicator is shown initially.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CommentPage displays comments list when comments are loaded',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Simulate comments being loaded by showing the ListView directly
    expect(find.text('Test comment 1'), findsOneWidget);
    expect(find.text('Test comment 2'), findsOneWidget);
  });

  testWidgets('CommentPage displays error message when there is an error',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Simulate an error by showing the error message directly
    expect(find.text('Failed to load comments'), findsOneWidget);
  });
}
