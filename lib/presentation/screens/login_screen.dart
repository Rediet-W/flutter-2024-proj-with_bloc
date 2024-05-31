import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../secure_storage_service.dart';

class LogInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SecureStorageService _secureStorageService = SecureStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoggedIn) {
            final List<String>? roles = await _secureStorageService.readRoles();
            print('User roles: $roles');
            if (roles != null) {
              if (roles.contains('admin')) {
                context.go('/admin');
              } else {
                context.go('/home');
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed: Roles not found')),
              );
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset('Assets/component.png',
                    alignment: Alignment.center, fit: BoxFit.fill),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text("Log In",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    TextFormField(
                      key: Key('emailField'),
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                    TextFormField(
                      key: Key('passwordField'),
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        context.go('/signup');
                      },
                      child: const Text(
                        'I do not have an account',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      key: Key('loginButton'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Image.asset('Assets/component1.png', fit: BoxFit.fill),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
