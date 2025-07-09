import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/event/data/appointmentService.dart';
import 'package:graduate_project/feature/event/logic/appointmentCubit.dart';
import 'package:graduate_project/feature/event/logic/appointmentState.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final timeFormatter = DateFormat.jm();
    final dateTimeFormatter = DateFormat('yyyy-MM-dd – hh:mm a');
    return BlocProvider(
      create: (_) =>
          AppointmentCubit(AppointmentService())..loadAppointmentsUpcoming(),
      child: Scaffold(
        appBar: AppBar(title: const Text("My Appointments")),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AppointmentLoaded) {
              return ListView.builder(
                itemCount: state.appointments.length,
                itemBuilder: (context, index) {
                  final appointment = state.appointments[index];
                  return Card(
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    "assets/images/onboarding_doctor.png"),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Doctor: ${appointment.fullName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "Specialization: ${appointment.specializationName}"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text("Clinic: ${appointment.clinicName}"),
                          Text(
                              "City: ${appointment.cityName}, ${appointment.governorateName}"),
                          Text("Amount: EGP ${appointment.amount}"),
                          Text(
                              "Confirmed: ${appointment.isConfirmed ? "Yes" : "No"}"),
                          Text(
                              "Appoint Date:${dateTimeFormatter.format(appointment.date)}"),
                          Text(
                              "Payment Date: ${dateTimeFormatter.format(appointment.paymentDate)}"),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                print(
                                    'Requesting: http://0.0.0.0:5237/api/Appointment/${appointment.appointmentId}/cancel');
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Cancel Appointment"),
                                    content: const Text(
                                        "Are you sure you want to cancel this appointment?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  try {
                                    await context
                                        .read<AppointmentCubit>()
                                        .cancelAppointment(
                                            appointment.id.toString());
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Appointment cancelled")),
                                    );
                                    context
                                        .read<AppointmentCubit>()
                                        .loadAppointmentsUpcoming();
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Failed: $e")),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.cancel),
                              label: const Text("Cancel Appointment"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is AppointmentError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
