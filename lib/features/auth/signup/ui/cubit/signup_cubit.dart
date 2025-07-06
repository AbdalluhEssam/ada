import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'sginup_state.dart';

class SignupCubit extends Cubit<SignUpState> {
  SignupCubit() : super(SignUpInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool obscureText2 = true;

  void toggleObscureText() {
    obscureText = !obscureText;
    emit(SignUpInitial());
  }
  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    emit(SignUpInitial());
  }

  void signUp() {
    if (formKey.currentState?.validate() == true) {
      emit(SignUpSuccess());
    }
  }
}
