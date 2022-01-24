import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});

  List<Object> get props => [email];
}

class SignUpPassword1Changed extends SignUpEvent {
  final String password1;

  SignUpPassword1Changed({required this.password1});

  List<Object> get props => [password1];
}

class SignUpPassword2Changed extends SignUpEvent {
  final String password2;

  SignUpPassword2Changed({required this.password2});

  List<Object> get props => [password2];
}

class SignUpSubmittedWithoutConfirmaation extends SignUpEvent {
  final String email;
  final String password1;
  final String password2;

  SignUpSubmittedWithoutConfirmaation(
      {required this.email, required this.password1, required this.password2});

  List<Object> get props => [email, password1, password2];
}

class SignUpSubmittedWithConfirmation extends SignUpEvent {
  final String email;
  final String password1;
  final String password2;

  SignUpSubmittedWithConfirmation(
      {required this.email, required this.password1, required this.password2});

  List<Object> get props => [email, password1, password2];
}

class SignUpFailure extends SignUpEvent {
  final String message;

  SignUpFailure({required this.message});

  @override
  List<Object> get props => [message];
}
