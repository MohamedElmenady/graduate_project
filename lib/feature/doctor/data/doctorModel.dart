class Appointment {
  final String id;
  final Patient patient;
  final AppointmentStatus status;
  final DateTime date;

  Appointment({
    required this.id,
    required this.patient,
    required this.status,
    required this.date,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patient: Patient.fromJson(json['patient']),
      status: _parseStatus(json['status']),
      date: DateTime.parse(json['date']),
    );
  }
  static AppointmentStatus _parseStatus(int statusCode) {
    switch (statusCode) {
      case 0:
        return AppointmentStatus.Pending;
      case 1:
        return AppointmentStatus.Completed;
      case 2:
        return AppointmentStatus.Payed;
      case 3:
        return AppointmentStatus.CanceledByUser;
      case 4:
        return AppointmentStatus.CanceledByDoctor;
      case 5:
        return AppointmentStatus.Expired;
      default:
        return AppointmentStatus.Pending;
    }
  }
}

class Patient {
  final String id;
  final String fullName;
  final String phoneNumber;

  Patient({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
  });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

enum AppointmentStatus {
  Pending,
  Completed,
  Payed,
  CanceledByUser,
  CanceledByDoctor,
  Expired,
}
