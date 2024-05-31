import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/auth/repository/auth_repository.dart';
import 'package:flutter_project/comment/repository/comment_repository.dart';
import 'package:flutter_project/post/bloc/post_bloc.dart';
import 'package:flutter_project/comment/bloc/comment_bloc.dart';
import 'package:flutter_project/post/repository/post_repository.dart';
import 'package:flutter_project/router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'auth/bloc/auth_bloc.dart';
import 'secure_storage_service.dart';
import 'auth/provider/auth_provider.dart';
import 'comment/provider/comment_provider.dart';
import 'post/provider/post_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SecureStorageService>(
          create: (_) => SecureStorageService(),
        ),
        Provider<http.Client>(
          create: (_) => http.Client(),
        ),
      ],
      child: AuthProvider(
        child: CommentProvider(
          child: PostProvider(
            child: MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(
                    authRepository: context.read<AuthRepository>(),
                  ),
                ),
                BlocProvider<CommentBloc>(
                  create: (context) => CommentBloc(
                    commentRepository: context.read<CommentRepository>(),
                  ),
                ),
                BlocProvider<PostBloc>(
                  create: (context) => PostBloc(
                    postRepository: context.read<PostRepository>(),
                  ),
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
          ),
        ),
      ),
    );
  }
}
