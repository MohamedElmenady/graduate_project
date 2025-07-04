import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/services/data/serviceModel.dart';
import 'package:graduate_project/feature/services/logic/cubitState.dart';
import 'package:http/http.dart' as http;

class SpecialityCubit extends Cubit<SpecialityState> {
  SpecialityCubit() : super(SpecialityInitial());

  static SpecialityCubit get(context) => BlocProvider.of(context);

  List<SpecialityModel> specialities = [];

  Future<void> fetchSpecialities() async {
    emit(SpecialityLoading());

    try {
      final response = await http.get(
        Uri.parse(baseUrlSpeciality),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'] as List;

        specialities = data
            .map((e) => SpecialityModel.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(SpecialitySuccess());
      } else {
        emit(SpecialityError('Error: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SpecialityError(e.toString()));
    }
  }
}
