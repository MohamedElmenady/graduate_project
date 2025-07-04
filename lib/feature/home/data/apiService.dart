import 'dart:convert';

import 'package:graduate_project/core/healpers/shared.dart';
import 'package:graduate_project/feature/home/data/doctor.dart';
import 'package:graduate_project/feature/services/data/serviceModel.dart';
import 'package:http/http.dart' as http;

import '../../../core/healpers/constants.dart';

class ApiService {
  // final String baseUrl = 'https://your-api.com/api'; // ضع رابط API الحقيقي

  getName() async {
    final response = await http.get(Uri.parse(baseUrlHomePage), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      String data = jsonDecode(response.body)['fullName'];
      await CashNetwork.set(key: 'name', value: data);
      name = data;
      await CashNetwork.get(key: 'name');
      print("User Name: $name");
      return data;
    } else {
      throw Exception('Failed to load specialities');
    }
  }

  Future<List<SpecialityModel>> getSpecialities() async {
    final response = await http.get(Uri.parse(baseUrlHomePage), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['specializations'];
      return data.map((e) => SpecialityModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load specialities');
    }
  }

  Future<List<Doctor>> getRecommendedDoctors() async {
    final response = await http.get(Uri.parse(baseUrlHomePage), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['recommendedDoctors'];
      return data.map((e) => Doctor.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}
