import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:note/logic/bloc/auth/auth_event.dart';
import 'package:note/logic/bloc/auth/auth_state.dart';
import 'package:note/data/model/formz/auth/email.dart';
import 'package:note/data/model/formz/auth/password.dart';
import 'package:note/data/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthState());

  final AuthRepository authRepository;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, password]),
      );
    } else if (event is EmailUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (event is FormSubmitted) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        status: Formz.validate([email, password]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        try {
          await authRepository.logInOrRegister(
            email: event.email,
            password: event.password,
          );
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } catch (err) {
          yield state.copyWith(
            errorMessage: err.toString(),
            status: FormzStatus.submissionFailure,
          );
        }
      }
    }
  }
}
