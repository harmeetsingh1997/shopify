import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final User? user;
  final String name;

  const SignUpSuccess(this.user, this.name);
}

class SignUpWithGoogle extends SignUpState{
  final User? user;

  SignUpWithGoogle(this.user);
}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure(this.error);
}

class ResetPasswordSuccess extends SignUpState{

}

class UserLogOut extends SignUpState{}



