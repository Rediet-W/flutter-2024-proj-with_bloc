import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_project/router.dart';
import 'auth/repository/auth_repository.dart';
import 'auth/bloc/auth_bloc.dart';
import 'comment/repository/comment_repository.dart';
import 'comment/bloc/comment_bloc.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final CommentRepository commentRepository =
      CommentRepository(baseUrl: 'http://10.0.2.2:3003/');
  final PostRepository postRepository =
      PostRepository(baseUrl: 'http://localhost:3003/');

  runApp(MyApp(
    authRepository: authRepository,
    commentRepository: commentRepository,
    postRepository: postRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CommentRepository commentRepository;
  final PostRepository postRepository;

  MyApp({
    required this.authRepository,
    required this.commentRepository,
    required this.postRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => authRepository,
        ),
        RepositoryProvider<CommentRepository>(
          create: (context) => commentRepository,
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => postRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<CommentBloc>(
            create: (context) => CommentBloc(
                commentRepository: context.read<CommentRepository>()),
          ),
          BlocProvider<PostBloc>(
            create: (context) =>
                PostBloc(postRepository: context.read<PostRepository>()),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router, // Use the GoRouter configuration
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
