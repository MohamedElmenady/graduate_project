import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/doctorService.dart';
import 'doctorState.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentService service;

  AppointmentCubit({required this.service}) : super(AppointmentInitial());

  Future<void> loadAppointments(String status) async {
    emit(AppointmentLoading());
    try {
      final appointments = await service.getAppointments(status);
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> confirmAppointment(String id) async {
    try {
      await service.confirmAppointment(id);
      loadAppointments("upcoming");
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> completeAppointment(String id) async {
    try {
      await service.completeAppointment(id);
      loadAppointments("upcoming");
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> cancelAppointment(String id) async {
    try {
      await service.cancelAppointment(id);
      loadAppointments("upcoming");
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}
