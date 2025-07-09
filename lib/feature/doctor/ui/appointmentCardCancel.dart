import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/doctorModel.dart';

class AppointmentCardCancel extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCardCancel({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateTimeFormatter = DateFormat('yyyy-MM-dd – hh:mm a');
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient: ${appointment.patient.fullName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${appointment.patient.phoneNumber}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${_getStatusText(appointment.status)}',
              style: TextStyle(
                fontSize: 14,
                color: _getStatusColor(appointment.status),
              ),
            ),
            const SizedBox(height: 8),
            Text("Appoint Date:${dateTimeFormatter.format(appointment.date)}"),
          ],
        ),
      ),
    );
  }

  String _getStatusText(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.Pending:
        return 'Pending';
      case AppointmentStatus.Completed:
        return 'Completed';
      case AppointmentStatus.Payed:
        return 'Payment Received';
      case AppointmentStatus.CanceledByUser:
        return 'Canceled by User';
      case AppointmentStatus.CanceledByDoctor:
        return 'Canceled by Doctor';
      case AppointmentStatus.Expired:
        return 'Expired';
    }
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.Pending:
        return Colors.orange;
      case AppointmentStatus.Completed:
        return Colors.green;
      case AppointmentStatus.Payed:
        return Colors.blue;
      case AppointmentStatus.CanceledByUser:
      case AppointmentStatus.CanceledByDoctor:
        return Colors.red;
      case AppointmentStatus.Expired:
        return Colors.grey;
    }
  }

  bool _shouldShowButtons(AppointmentStatus status) {
    return status != AppointmentStatus.Completed &&
        status != AppointmentStatus.CanceledByUser &&
        status != AppointmentStatus.CanceledByDoctor &&
        status != AppointmentStatus.Expired;
  }

  bool _shouldShowCancelButton(AppointmentStatus status) {
    return status == AppointmentStatus.Pending ||
        status == AppointmentStatus.Payed;
  }
}
