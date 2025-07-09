import 'dart:convert';

import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/event/data/appointmentModel.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  Future<List<Appointment>> fetchAppointments() async {
    final response = await http.get(Uri.parse(baseUrlEvent), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      // 'Parameter': status,
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print((data));
      return data.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch appointments: ${response.statusCode}');
    }
  }
}
