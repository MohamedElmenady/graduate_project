import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/login/logic/login_state.dart';
import 'package:http/http.dart' as http;

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLogin());
  bool isObscureText = true;
  void vision() {
    isObscureText = !isObscureText;
    emit(SuccessState());
  }

  void login({required String email, required String pass}) async {
    //emit(LodingLogin());
    try {
      emit(LodingLogin());
      final response = await http.post(
        Uri.parse("http://10.0.2.2:7260/api/Auth/login"),
        body: {
          "email": email,
          "password": pass,
        },
      );
      final responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        emit(SuccessLogin());
      } else {
        emit(FailueirLogin(message: responseBody['message']));
      }
    } catch (e) {
      emit(FailueirLogin(message: "خطأ في الاتصال بالسيرفر: $e"));
      print(e);
    }
  }
}
