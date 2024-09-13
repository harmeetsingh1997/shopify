import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/auth_data_source.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;

  SignUpBloc(this.userRepository) : super(SignUpInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(SignUpInitial());
      try {
        final User? user = await userRepository.signUp(event.email, event.password,event.name);
        emit(SignUpSuccess(user,event.name));
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
    on<SignInButtonPressed>((event,emit)async{
try {
  User? user = await userRepository.signIn(event.email, event.password);
  emit(SignUpSuccess(user, event.email));
}catch(e){
  emit(SignUpFailure(e.toString()));
}
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(SignUpInitial());
      try {
        final User? user = await userRepository.signInWithGoogle();
        if (user != null) {
          emit(SignUpWithGoogle(user));
        } else {
          emit(const SignUpFailure('failed'));
        }
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
    on<ResetPassword>((event,emit)async{
    try {
       await userRepository.resetPassword(event.email);
      emit(ResetPasswordSuccess());
    }
    catch(e){
      emit(SignUpFailure(e.toString()));
    }
    });
    on<SignOut>((event,emit)async{
      await userRepository.logOut();
      emit(UserLogOut());
    });
  }
}
