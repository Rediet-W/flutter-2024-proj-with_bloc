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
import 'package:flutter_project/presentation/screens/admin_screen/comment_admin.dart';
import 'package:flutter_project/presentation/screens/admin_screen/adminDetail.dart';
import 'package:flutter_project/post/model/post.dart';
import 'package:mongo_dart/mongo_dart.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => NoAccount(),
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
          builder: (context, state) {
            final postId = state.extra as String?;
            return CommentPage(
              postId: postId != null ? ObjectId.parse(postId) : ObjectId(),
            );
          },
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
        // Uncomment and modify this route if you need a detail page
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
