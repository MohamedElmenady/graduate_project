import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/appointment/appointment.dart';
import 'package:graduate_project/feature/appointment/data/bookingService.dart';
import 'package:graduate_project/feature/appointment/logic/bookingCubit.dart';
import 'package:graduate_project/feature/home/logic/homeCubit.dart';
import 'package:graduate_project/feature/home/logic/homeState.dart';

import 'data/apiService.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //name = CashNetwork.get(key: 'name');
    return BlocProvider(
      create: (context) => HomeCubit(ApiService())..fetchData(),
      child: Scaffold(
        appBar: AppBar(title: Text('Hi, ${name ?? 'sir'}!')),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildSpecialities(state),
                  const SizedBox(height: 16),
                  _buildDoctors(state, context),
                ],
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.medical_services, size: 50, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Book and schedule with nearest doctor',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Find Nearby'))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSpecialities(HomeLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Doctor Speciality',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.specialities.length,
            itemBuilder: (context, index) {
              final item = state.specialities[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(item.name)),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildDoctors(HomeLoaded state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recommendation Doctor',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Column(
          children: state.doctors.map((doctor) {
            return Card(
              child: Column(children: [
                ListTile(
                  leading: const Icon(Icons.person, size: 40),
                  title: Text(doctor.fullName),
                  subtitle: Text(
                      '${doctor.specializationName} | ${doctor.clinicName}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('${doctor.rating} (${doctor.reviewsCount})'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => BookingCubit(BookingService()),
                          child: BookingScreen(doctorId: doctor.id),
                        ),
                      ),
                    );
                  },
                  child: const Text("Make Appointment"),
                ),
              ]),
            );
          }).toList(),
        ),
      ],
    );
  }
}
