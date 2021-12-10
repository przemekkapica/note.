import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/logic/bloc/auth/auth_bloc.dart';
import 'package:note/logic/bloc/auth/auth_event.dart';
import 'package:note/logic/bloc/auth/auth_state.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            labelText: 'Email',
            errorText: state.email.invalid ? 'Invalid email' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => _onChanged(context, value),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

  void _onChanged(BuildContext context, String value) =>
      context.read<AuthBloc>().add(EmailChanged(email: value));
}
