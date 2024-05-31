import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/post/repository/post_repository.dart';

class PostProvider extends StatelessWidget {
  final Widget child;

  PostProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    final PostRepository postRepository = PostRepository(
      baseUrl: 'http://10.0.2.2:3003/',
      // httpClient: httpClient,
      // client: httpClient,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostRepository>(
          create: (context) => postRepository,
        ),
      ],
      child: child,
    );
  }
}
