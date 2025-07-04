import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/profile/personal_info/data/userModel.dart';
import 'package:graduate_project/feature/profile/personal_info/logic/stateCubit.dart';
import 'package:http/http.dart' as http;

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> updateProfile(EditModel user) async {
    emit(EditProfileLoading());

    try {
      final response = await http.put(
        Uri.parse(baseUrlUpdateProfile), // ✅ غيّر اللينك
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // ✅ غيّر التوكن
        },
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        emit(EditProfileSuccess());
      } else {
        print("Error: ${response.body}");
        emit(EditProfileError("Failed: ${response.statusCode}"));
        //print("Error: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
      emit(EditProfileError("Exception: $e"));
    }
  }
}
