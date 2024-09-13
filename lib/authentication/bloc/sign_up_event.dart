

abstract class SignUpEvent{

}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String name;

  SignUpButtonPressed({required this.email, required this.password, required this.name,});
}
class SignInButtonPressed extends SignUpEvent{
  final String email;
  final String password;

  SignInButtonPressed ({required this.email,required this.password});
}
class GoogleSignInRequested extends SignUpEvent {}


class ResetPassword extends SignUpEvent{
  final String email;

  ResetPassword(this.email);
}

class SignOut extends SignUpEvent{}









