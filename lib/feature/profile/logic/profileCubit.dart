import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/profile/data/userModel.dart';
import 'package:graduate_project/feature/profile/logic/stateCubit.dart';
import 'package:http/http.dart' as http;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  //String token = token; // استبدله بالتوكن الحقيقي
  UserModel? user;
  void fetchUserData() async {
    emit(ProfileLoading());
    try {
      final response = await http.get(
        Uri.parse(baseUrlProfile), // استبدل بالرابط الصحيح
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = UserModel.fromJson(data); // مباشرةً من الـ JSON
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("Failed to load data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
