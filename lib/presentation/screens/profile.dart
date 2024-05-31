import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/repository/auth_repository.dart';
import '../../secure_storage_service.dart';

class ProfileTwo extends StatelessWidget {
  const ProfileTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();

    return BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository)
        ..add(LoadUserProfile('user-id-from-secure-storage')),
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  bool _isPasswordEnabled = false;
  bool _isEmailEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[300],
        title: const Center(
          child: Text(
            'Your Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            _password.text = ''; // Password shouldn't be displayed
            _email.text = state.user.email;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 100.0,
                        child: Icon(
                          Icons.account_circle,
                          size: 200,
                        ),
                      ),
                      const Divider(
                        height: 60,
                        color: Colors.black,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildProfileField(
                              "Password", _password, _isPasswordEnabled),
                          buildProfileField("Email", _email, _isEmailEnabled),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                UpdateUserProfile('user-id-from-secure-storage',
                                    _password.text),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                DeleteUserProfile(
                                    'user-id-from-secure-storage'),
                              );
                            },
                            child: Icon(Icons.delete),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ProfileUpdated) {
            return Center(child: Text('Profile Updated Successfully!'));
          } else if (state is ProfileDeleted) {
            return Center(child: Text('Profile Deleted Successfully!'));
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget buildProfileField(
      String label, TextEditingController controller, bool isEnabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                letterSpacing: 2.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controller,
                    enabled: isEnabled,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.abc),
                  onPressed: () {
                    setState(() {
                      if (label == "Password") {
                        _isPasswordEnabled = !_isPasswordEnabled;
                      } else if (label == "Email") {
                        _isEmailEnabled = _isEmailEnabled;
                      }
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
