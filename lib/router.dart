import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_project/presentation/screens/login_screen.dart';
import 'package:flutter_project/presentation/screens/signup_screen.dart';
import 'package:flutter_project/presentation/screens/comment_page.dart';
import 'package:flutter_project/presentation/screens/create_post_page.dart';
import 'package:flutter_project/presentation/screens/detailpage.dart';
import 'package:flutter_project/presentation/screens/noaccount.dart';
import 'package:flutter_project/presentation/screens/profile.dart';
import 'package:flutter_project/presentation/screens/withaccount.dart';
import 'package:flutter_project/presentation/widgets/nav.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => LogInPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (context, state) => LogInPage(),
        ),
        GoRoute(
          path: 'signup',
          builder: (context, state) => SignUpPage(),
        ),
        GoRoute(
          path: 'comment',
          builder: (context, state) => CommentPage(postId: 'postId'),
        ),
        GoRoute(
          path: 'home',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: 'newpost',
          builder: (context, state) => CreatePostPage(),
        ),
        GoRoute(
          path: 'noaccount',
          builder: (context, state) => NoAccount(),
        ),
        GoRoute(
          path: 'withaccount',
          builder: (context, state) => WithAccount(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => ProfileTwo(),
        ),
        // GoRoute(
        //   path: 'detail',
        //   builder: (context, state) => ItemPage(
        //     postId: '',
        //   ),
        // ),
      ],
    ),
  ],
);
