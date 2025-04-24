import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_state.dart';
import 'package:http/http.dart' as http;

import '../../../core/healpers/constants.dart';

class SignupCubit extends Cubit<SignUpState> {
  SignupCubit() : super(SignUpInitial());

  void register(
      {required String name,
      required String email,
      required String phone,
      required String pass}) async {
    emit(SignUpLoading());
    http.Response response = await http.post(
      Uri.parse(baseUrlRegister),
      body: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": pass,
      },
      //headers: {'lang': 'en'},
    );
    var responseBody = jsonDecode(response.body);
    debugPrint(responseBody);
    if (responseBody['status'] == true) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpFailure(message: responseBody['message']));
    }
  }
}
