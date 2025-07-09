import 'dart:convert';

import 'package:graduate_project/core/healpers/constants.dart';
import 'package:http/http.dart' as http;

import 'doctorModel.dart';

class AppointmentService {
  Future<List<Appointment>> getAppointments(String status) async {
    final response = await http.get(
      Uri.parse('http://192.168.1.5:5237/api/Appointment/my?Status=$status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Appointment.fromJson(json)).toList();
    }
    throw Exception('Failed to load appointments');
  }

  Future<void> confirmAppointment(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Appointment/{$id}/confirm'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to confirm appointment');
    }
  }

  Future<void> completeAppointment(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Appointment/{$id}/complete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to complete appointment');
    }
  }

  Future<void> cancelAppointment(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Appointment/{$id}/doctor-cancel'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to cancel appointment');
    }
  }
}
