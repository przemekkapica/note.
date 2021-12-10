import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:note/data/model/formz/auth/email.dart';
import 'package:note/data/model/formz/auth/password.dart';

class AuthState extends Equatable {
  const AuthState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = '',
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String errorMessage;

  AuthState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? errorMessage}) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status, errorMessage];
}
