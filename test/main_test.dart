// import 'package:flutter_project/post/repository/post_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_project/main.dart';
// import 'package:flutter/material.dart';

// void main() {
//   testWidgets('App initialization test', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp(
//         postRepository:
//             PostRepository(baseUrl: 'http://localhost:3003/', client: null)));

//     expect(find.byType(MaterialApp), findsOneWidget);
//   });
// }
import 'package:flutter_test/flutter_test.dart';

// Import test files for each bloc
import './post/bloc/post_bloc_test.dart' as post_bloc_test;
import './comment/bloc/comment_bloc_test.dart' as comment_bloc_test;
import './auth/bloc/auth_bloc_test.dart' as auth_bloc_test;
import './auth/repository/auth_repository_test.dart' as auth_repo_test;
import 'comment/repository/comment_repository_test.dart' as comment_repo_test;
import './post/repository/post_repository_test.dart' as post_repo_test;
import './auth/model/auth_model_test.dart' as auth_model_test;
import './comment/model/comment_model_test.dart' as comment_model_test;
import './post/model/post_model_test.dart' as post_model_test;
import './auth/provider/auth_provider_test.dart' as auth_provider_test;
import './comment/provider/comment_provider_test.dart' as comment_provider_test;
import './post/provider/post_provider_test.dart' as post_provider_test;

void main() {
  group('Bloc Tests', () {
    // Call the tests for each bloc
    post_bloc_test.main();
    comment_bloc_test.main();
    auth_bloc_test.main();
    // call the tests for each repository
    auth_repo_test.main();
    comment_repo_test.main();
    post_repo_test.main();
    // call the tests for each provider
    auth_provider_test.main();
    comment_provider_test.main();
    post_provider_test.main();
    // call the tests for each model
    auth_model_test.main();
    comment_model_test.main();
    post_model_test.main();
  });
}
