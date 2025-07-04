abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}

//class PaymentInitial extends BookingState {}

class PaymentLoading extends BookingState {}

class PaymentSuccess extends BookingState {}

class PaymentError extends BookingState {
  final String message;
  PaymentError(this.message);
}
