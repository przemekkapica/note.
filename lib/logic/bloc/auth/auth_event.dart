import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends AuthEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends AuthEvent {}

class PasswordChanged extends AuthEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends AuthEvent {}

class FormSubmitted extends AuthEvent {
  const FormSubmitted({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
