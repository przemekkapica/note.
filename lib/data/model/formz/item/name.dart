import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Name extends FormzInput<String, PasswordValidationError> {
  const Name.pure([String value = '']) : super.pure(value);
  const Name.dirty([String value = '']) : super.dirty(value);

  static final _nameRegex = RegExp(r'^(?!\s*$).+');

  @override
  PasswordValidationError? validator(String? value) {
    value = value!.trim();
    return _nameRegex.hasMatch(value) ? null : PasswordValidationError.invalid;
  }
}
