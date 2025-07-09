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
  final codeController = TextEditingController();
  void register({
    required String name,
    required String email,
    required String phone,
    required String pass,
  }) async {
    try {
      emit(SignUpLoading());

      final response = await http.post(
        Uri.parse(baseUrlRegister),
        body: jsonEncode({
          "fullName": name,
          "email": email,
          "phoneNumber": phone,
          "password": pass,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.body.isEmpty) {
        emit(SignUpFailure(message: "Empty response from server"));
        return;
      }

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['status'] == true) {
          emit(SignUpSuccess());
        } else {
          emit(SignUpFailure(
              message: responseBody['message'] ?? 'Unknown error'));
        }
      } else {
        emit(SignUpFailure(
            message: responseBody['message'] ?? 'Something went wrong'));
      }
    } catch (e) {
      emit(SignUpFailure(message: e.toString()));
    }
  }

  /* void clearFields() {
    namecontrol.clear();
    emailcontrol.clear();
    phonecontrol.clear();
    passcontrol.clear();
  }*/

  Future<void> confirmEmail(
      {required String code, required String email}) async {
    print(email);
    emit(ConfirmEmailLoading());
    final url = Uri.parse(baseUrlConfirmEmail);
    final body = {
      'email': email,
      'code': code,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        emit(ConfirmEmailSuccess());
        //clearFields();
      } else {
        emit(ConfirmEmailError("Invalid code or email"));
      }
    } catch (e) {
      emit(ConfirmEmailError(e.toString()));
    }
  }
}
