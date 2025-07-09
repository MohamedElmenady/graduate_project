import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:graduate_project/feature/doctor/data/doctorModel.dart';
import 'package:graduate_project/feature/doctor/logic/doctorCubit.dart';
import 'package:graduate_project/feature/doctor/ui/appointmentComplet.dart';

import 'data/doctorService.dart';
import 'logic/doctorState.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AppointmentCubit(
          service: AppointmentService(),
        )..loadAppointments("completed"),
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

                  return AppointmentCardComplet(appointment: appointment);
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
