import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Note extends FormzInput<String, PasswordValidationError> {
  const Note.pure([String value = '']) : super.pure(value);
  const Note.dirty([String value = '']) : super.dirty(value);

  static final _noteRegex = RegExp(r'^(?!\s*$).+');

  @override
  PasswordValidationError? validator(String? value) {
    value = value!.trim();
    return null;
    // return _noteRegex.hasMatch(value)
    //     ? null
    //     : PasswordValidationError.invalid;
  }
}
