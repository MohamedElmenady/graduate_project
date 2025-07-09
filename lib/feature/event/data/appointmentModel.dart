class Appointment {
  final String id;
  final String fullName;
  final String specializationName;
  final String clinicName;
  final String imageUrl;
  final String cityName;
  final String governorateName;
  final String appointmentId;
  final bool isConfirmed;
  final double amount;
  final DateTime date;
  final DateTime paymentDate;

  Appointment({
    required this.id,
    required this.fullName,
    required this.specializationName,
    required this.clinicName,
    required this.imageUrl,
    required this.cityName,
    required this.governorateName,
    required this.isConfirmed,
    required this.amount,
    required this.date,
    required this.paymentDate,
    required this.appointmentId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    final paymentInfo = json['paymentInfo'];

    return Appointment(
      id: json['id'],
      fullName: json['doctor']['fullName'],
      specializationName: json['doctor']['specializationName'],
      clinicName: json['doctor']['clinicName'],
      imageUrl: json['doctor']['imageUrl'],
      cityName: json['doctor']['cityName'],
      governorateName: json['doctor']['governorateName'],
      isConfirmed: paymentInfo?['isConfirmed'] ?? false,
      appointmentId: paymentInfo?['appointmentId'] ?? '',
      amount: (paymentInfo?['amount'] ?? 0).toDouble(),
      date: DateTime.parse(json['date']),
      paymentDate: paymentInfo?['paymentDate'] != null
          ? DateTime.parse(paymentInfo['paymentDate'])
          : DateTime.now(),
    );
  }
}
