import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/src/provider.dart';
import 'package:note/logic/bloc/auth/auth_bloc.dart';
import 'package:note/logic/bloc/auth/auth_event.dart';

List<FocusNode> useAuth() {
  return use(const _UseAuth());
}

class _UseAuth extends Hook<List<FocusNode>> {
  const _UseAuth();

  @override
  __UseAuthState createState() => __UseAuthState();
}

class __UseAuthState extends HookState<List<FocusNode>, _UseAuth> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initHook() {
    super.initHook();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<AuthBloc>().add(EmailUnfocused());
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<AuthBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  List<FocusNode> build(BuildContext context) {
    return [_emailFocusNode, _passwordFocusNode];
  }
}
