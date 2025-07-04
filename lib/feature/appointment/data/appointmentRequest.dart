class AppointmentRequest {
  final String doctorId;
  final DateTime date;

  AppointmentRequest({
    required this.doctorId,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "doctorId": doctorId,
      "date": date.toUtc().toIso8601String(),
    };
  }
}

class PaymentRequest {
  final String appointmentId;
  final double amount;
  final int method;

  PaymentRequest({
    required this.appointmentId,
    required this.amount,
    this.method = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'amount': amount,
      'method': method,
    };
  }
}
