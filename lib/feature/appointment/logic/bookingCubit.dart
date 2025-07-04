import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/appointment/data/appointmentRequest.dart';
import 'package:graduate_project/feature/appointment/data/bookingService.dart';
import 'package:graduate_project/feature/appointment/logic/bookingState.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingService service;

  BookingCubit(this.service) : super(BookingInitial());

  Future<void> submitPayment(PaymentRequest request) async {
    emit(PaymentLoading());
    try {
      await service.submitPayment(request);
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> bookAppointment(AppointmentRequest request) async {
    emit(BookingLoading());
    try {
      await service.bookAppointment(request);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
