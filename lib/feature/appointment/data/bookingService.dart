import 'dart:convert';

import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/core/healpers/shared.dart';
import 'package:graduate_project/feature/appointment/data/appointmentRequest.dart';
import 'package:http/http.dart' as http;

class BookingService {
  Future<void> submitPayment(PaymentRequest request) async {
    final response = await http.post(
      Uri.parse(baseUrlPayment),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(request.toJson()),
    );
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Payment failed: ${response.body}');
    }
  }

  Future<void> bookAppointment(AppointmentRequest request) async {
    final response = await http.post(
      Uri.parse(baseUrlBooking),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );
    print(response.body);

    if (response.statusCode != 200) {
      throw Exception('Booking failed: ${response.body}');
    }
    String appointId = jsonDecode(response.body)['data']['id'];
    await CashNetwork.set(key: 'appointmentId', value: appointId);
    appointment1Id = appointId;
    await CashNetwork.get(key: 'appointmentId');
    print("Appointment ID: $appointment1Id");
  }
}
