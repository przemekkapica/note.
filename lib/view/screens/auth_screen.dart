import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:formz/formz.dart';
import 'package:note/logic/bloc/auth/auth_bloc.dart';
import 'package:note/logic/bloc/auth/auth_state.dart';
import 'package:note/utils/constants.dart';
import 'package:note/logic/hooks/auth_hook.dart';
import 'package:note/view/widgets/info_dialog.dart';
import 'package:note/view/widgets/inputs/email_input.dart';
import 'package:note/view/widgets/inputs/password_input.dart';
import 'package:note/view/widgets/buttons/auth_button.dart';
import 'package:note/view/widgets/page_padding.dart';

class AuthScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final auth = useAuth();
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, blocState) {
          if (blocState.status.isSubmissionSuccess) {
            navigateToHomeScreen(context);
          }
          if (blocState.status.isSubmissionFailure) {
            showInfoDialog(context, blocState);
          }
          if (blocState.status.isSubmissionInProgress) {
            showProgressIndicator(context);
          }
        },
        child: blocBuilder(auth),
      ),
    );
  }

  void showProgressIndicator(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  bool _hasFocus(auth) {
    if (auth[0].hasFocus || auth[1].hasFocus) {
      return true;
    } else {
      return false;
    }
  }

  void showInfoDialog(BuildContext context, AuthState blocState) {
    Navigator.pop(context);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => InfoDialog(description: blocState.errorMessage),
    );
  }

  BlocBuilder<AuthBloc, AuthState> blocBuilder(List<FocusNode> auth) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, blocState) {
        return KeyboardVisibilityProvider(
          child: PagePadding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                authLogo(context),
                authCard(auth),
              ],
            ),
          ),
        );
      },
    );
  }

  Card authCard(List<FocusNode> auth) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 40, 24, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            EmailInput(focusNode: auth[0]),
            SizedBox(height: 15),
            PasswordInput(focusNode: auth[1]),
            SizedBox(height: 40),
            AuthButton(),
          ],
        ),
      ),
    );
  }

  KeyboardVisibilityBuilder authLogo(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      if (isKeyboardVisible) {
        return SizedBox.shrink();
      } else {
        return Row(
          children: [
            Icon(Icons.notes_rounded, size: 48, color: Colors.deepPurple),
            Text(
              'Note.',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.deepPurple),
            ),
          ],
        );
      }
    });
  }

  void navigateToHomeScreen(context) {
    Navigator.pushReplacementNamed(context, HOME_ROUTE);
  }
}
