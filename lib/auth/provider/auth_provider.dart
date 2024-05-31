import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/auth/repository/auth_repository.dart';

class AuthProvider extends StatelessWidget {
  final Widget child;

  AuthProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    final http.Client httpClient = http.Client();
    final AuthRepository authRepository = AuthRepository(
      baseUrl: 'http://10.0.2.2:3003/auth',
      httpClient: httpClient,
      secureStorageService: context.read(),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => authRepository,
        ),
      ],
      child: child,
    );
  }
}
