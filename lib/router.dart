import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_project/auth/screens/login_screen.dart';
import 'package:flutter_project/auth/screens/signup_screen.dart';
import 'package:flutter_project/comment/screens/comment_page.dart';
import 'package:flutter_project/post/screens/create_post_page.dart';
import 'package:flutter_project/presentation/screens/detailpage.dart';
import 'package:flutter_project/presentation/screens/noaccount.dart';
import 'package:flutter_project/presentation/screens/profile.dart';
import 'package:flutter_project/presentation/screens/withaccount.dart';
import 'package:flutter_project/presentation/widgets/nav.dart';
import 'package:flutter_project/presentation/screens/admin_screen/comment_admin.dart';
import 'package:flutter_project/presentation/screens/admin_screen/adminDetail.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>  NoAccount(),
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
          path: 'admin',
          builder: (context, state) => AdminItemPage(),
        ),
        GoRoute(
          path: 'admin_comment',
          builder: (context, state) => AdminCommentPage(),
        ),
        GoRoute(
          path: 'newpost',
          builder: (context, state) => LostFoundForm(),
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
