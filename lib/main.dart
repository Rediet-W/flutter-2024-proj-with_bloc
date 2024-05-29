import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'post/bloc/post_bloc.dart';
import 'post/repository/post_repository.dart';
import 'post/screens/create_post_page.dart';
import 'presentation/screens/detailpage.dart';
import 'presentation/screens/noaccount.dart';
import 'presentation/screens/profile.dart';
import 'presentation/screens/withaccount.dart';
import 'presentation/widgets/nav.dart';
import 'auth/repository/auth_repository.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/screens/login_screen.dart';
import 'auth/screens/signup_screen.dart';
import 'comment/repository/comment_repository.dart';
import 'comment/bloc/comment_bloc.dart';
import 'comment/screens/comment_page.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final CommentRepository commentRepository =
      CommentRepository(baseUrl: 'http://10.0.2.2:3003/');
  final PostRepository postRepository =
      PostRepository(baseUrl: 'http://10.0.2.2:3003/');

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

  MyApp(
      {required this.authRepository,
      required this.commentRepository,
      required this.postRepository});

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
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => LogInPage(),
            '/signup': (context) => SignUpPage(),
            '/comment': (context) => CommentPage(postId: 'postId'),
            '/home': (context) => HomeScreen(),
            '/newpost': (context) => NewPost(),
            '/noaccount': (context) => NoAccount(),
            '/withaccount': (context) => WithAccount(),
            '/profile': (context) => ProfileTwo(),
            '/detail': (context) => ItemPage(),
          },
        ),
      ),
    );
  }
}
