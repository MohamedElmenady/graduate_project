import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_state.dart';
import 'package:http/http.dart' as http;

class SignupCubit extends Cubit<SignUpState> {
  SignupCubit() : super(SignUpInitial());
  bool isObscureText = true;
  void vision() {
    isObscureText = !isObscureText;
    emit(SuccessState());
  }

  final namecontrol = TextEditingController();
  final emailcontrol = TextEditingController();
  final phonecontrol = TextEditingController();
  final passcontrol = TextEditingController();
  void register(
      {required String name,
      required String email,
      required String phone,
      required String pass}) async {
    try {
      emit(SignUpLoading());
      http.Response response = await http.post(
        Uri.parse(baseUrlRegister),
        body: jsonEncode({
          "fullName": name,
          "email": email,
          "phoneNumber": phone,
          "password": pass
        }),
        headers: {'Content-Type': 'application/json'},
      );
      var responseBody = jsonDecode(response.body);
      // ignore: avoid_print
      print("/////////////////////$responseBody///////////////////////");
      if (responseBody['status'] == true) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure(message: responseBody['message']));
      }
    } catch (e) {
      emit(SignUpFailure(message: e.toString()));
    }
  }
}
