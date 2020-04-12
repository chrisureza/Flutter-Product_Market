import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:form_validation_bloc/src/blocs/validators.dart';

class LoginBloc with Validators {
  // BehaviorSubject is a Stream for RXDart and is broadcast by default
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Get values of the stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidation);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidation);

// Get if both Streams are valid
  Stream<bool> get validFormStream => CombineLatestStream.combine2(
        emailStream,
        passwordStream,
        (emailIsValid, passwordIsValid) => true,
      );

  // Get last values of the streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  // Insert values to the stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
