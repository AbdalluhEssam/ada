import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscureText = true;

  void toggleObscureText() {
    obscureText = !obscureText;
    emit(LoginInitial());
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      emit(LoginSuccess());
    }
  }
}
