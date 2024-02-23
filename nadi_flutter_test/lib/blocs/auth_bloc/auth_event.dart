part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String username;
  final String password;

  AuthLogin({required this.username, required this.password});
}
