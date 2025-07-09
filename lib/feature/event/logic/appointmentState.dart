import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/event/data/appointmentService.dart';
import 'package:graduate_project/feature/event/logic/appointmentCubit.dart';
import 'package:http/http.dart' as http;

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentService service;
  AppointmentCubit(this.service) : super(AppointmentInitial());
  Future<void> cancelAppointment(String appointmentId) async {
    final url = Uri.parse(
        'http://192.168.1.5:5237/api/Appointment/{$appointmentId}/cancel');

    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      emit(AppointmentCancelled());
      print("Appointment cancelled successfully");
    } else {
      emit(AppointmentError('Failed to cancel appointment'));
      throw Exception('Failed to cancel appointment: ${response.statusCode}');
    }
  }

  Future<void> loadAppointmentsUpcoming() async {
    emit(AppointmentLoading());
    try {
      final appointments = await service.fetchAppointments();
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  /* Future<void> loadAppointmentsCompleted() async {
    emit(AppointmentLoading());
    try {
      final appointments = await service.fetchAppointments('completed');
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> loadAppointmentsCancelled() async {
    emit(AppointmentLoading());
    try {
      final appointments = await service.fetchAppointments('cancelled');
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }*/
}
