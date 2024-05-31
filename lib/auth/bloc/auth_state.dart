import 'package:equatable/equatable.dart';
import 'package:flutter_project/auth/model/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User user;

  const AuthLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileInitial extends AuthState {}

class ProfileLoading extends AuthState {}

class ProfileLoaded extends AuthState {
  final User user;

  ProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileError extends AuthState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileUpdating extends AuthState {}

class ProfileUpdated extends AuthState {
  final User user;

  const ProfileUpdated(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileDeleting extends AuthState {}

class ProfileDeleted extends AuthState {}
