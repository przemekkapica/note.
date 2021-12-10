import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:note/logic/bloc/auth/auth_bloc.dart';
import 'package:note/logic/bloc/auth/auth_event.dart';
import 'package:note/logic/bloc/auth/auth_state.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key}) : super(key: key);

  _logInOrRegister(BuildContext context) {
    final String email = context.read<AuthBloc>().state.email.value;
    final String password = context.read<AuthBloc>().state.password.value;

    context
        .read<AuthBloc>()
        .add(FormSubmitted(email: email, password: password));
  }

  @override
  Widget build(BuildContext context2) {
    return Container(
      width: double.infinity,
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, blocState) {
          return ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.subtitle1),
            ),
            onPressed: blocState.status.isValidated
                ? () => _logInOrRegister(context2)
                : null,
            child: Text('Sign in'),
          );
        },
      ),
    );
  }
}
