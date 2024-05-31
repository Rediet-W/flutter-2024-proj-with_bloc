import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';

class CommentProvider extends StatelessWidget {
  final Widget child;

  CommentProvider({required this.child});

  set commentRepository(CommentRepository commentRepository) {}

  @override
  Widget build(BuildContext context) {
    final CommentRepository commentRepository = CommentRepository(
      baseUrl: 'http://10.0.2.2:3003/',
      // httpClient: httpClient,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CommentRepository>(
          create: (context) => commentRepository,
        ),
      ],
      child: child,
    );
  }
}
