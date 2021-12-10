import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/logic/bloc/auth/auth_bloc.dart';
import 'package:note/logic/bloc/auth/auth_event.dart';
import 'package:note/logic/bloc/auth/auth_state.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            labelText: 'Password',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) => _onChanged(context, value),
          textInputAction: TextInputAction.done,
        );
      },
    );
  }

  void _onChanged(BuildContext context, String value) =>
      context.read<AuthBloc>().add(PasswordChanged(password: value));
}
