import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/doctor/data/doctorModel.dart';
import 'package:graduate_project/feature/doctor/logic/doctorState.dart';

import 'appointmentCard.dart';
import 'data/doctorService.dart';
import 'logic/doctorCubit.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AppointmentCubit(
          service: AppointmentService(),
        )..loadAppointments("upcoming"),
        child: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AppointmentError) {
              return Center(child: Text(state.message));
            } else if (state is AppointmentLoaded) {
              return ListView.builder(
                itemCount: state.appointments.length,
                itemBuilder: (context, index) {
                  final appointment = state.appointments[index];
                  if (appointment.status == AppointmentStatus.CanceledByUser ||
                      appointment.status ==
                          AppointmentStatus.CanceledByDoctor ||
                      appointment.status == AppointmentStatus.Expired) {
                    return const SizedBox.shrink();
                  }
                  return AppointmentCard(appointment: appointment);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
