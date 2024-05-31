import 'package:equatable/equatable.dart';
import '../model/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends AuthEvent {
  final String userId;

  LoadUserProfile(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateUserProfile extends AuthEvent {
  final String userId;

  final String password;

  UpdateUserProfile(this.userId, this.password);
}

class DeleteUserProfile extends AuthEvent {
  final String userId;

  const DeleteUserProfile(this.userId);

  @override
  List<Object> get props => [userId];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const SignupEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}

class LogoutEvent extends AuthEvent {}
