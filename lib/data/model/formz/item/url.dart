import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Url extends FormzInput<String, PasswordValidationError> {
  const Url.pure([String value = '']) : super.pure(value);
  const Url.dirty([String value = '']) : super.dirty(value);

  static final _urlRegex = RegExp(r'^(?!\s*$).+');

  @override
  PasswordValidationError? validator(String? value) {
    value = value!.trim();
    return null;
    // return _urlRegex.hasMatch(value)
    //     ? null
    //     : PasswordValidationError.invalid;
  }
}
