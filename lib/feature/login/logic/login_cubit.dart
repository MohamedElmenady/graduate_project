import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/core/healpers/shared.dart';
import 'package:graduate_project/feature/login/logic/login_state.dart';
import 'package:http/http.dart' as http;

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLogin());
  bool isObscureText = true;
  void vision() {
    isObscureText = !isObscureText;
    emit(SuccessState());
  }

  final emailcontrol = TextEditingController();
  final passcontrol = TextEditingController();

  void login({required String email, required String pass}) async {
    try {
      emit(LodingLogin());
      http.Response response = await http.post(Uri.parse(baseUrlLogin),
          body: jsonEncode({
            "email": email,
            "password": pass,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      var responseBody = jsonDecode(response.body);
      // ignore: avoid_print
      print("////////////$responseBody //////////////////");
      if (response.statusCode == 200) {
        if (responseBody['status'] == true) {
          String token1 = responseBody['data']['token'];
          await CashNetwork.set(key: 'token', value: token1);
          token = token1;
          await CashNetwork.get(key: 'token');
          emit(SuccessLogin());
        }
      } else {
        emit(FailueirLogin(message: responseBody['message']));
      }
    } catch (e) {
      emit(FailueirLogin(message: e.toString()));
    }
  }
}
