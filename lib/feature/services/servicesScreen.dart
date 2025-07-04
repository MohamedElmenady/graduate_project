import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/services/logic/cubitState.dart';
import 'package:graduate_project/feature/services/logic/serviceCubit.dart';

class SpecialityScreen extends StatelessWidget {
  SpecialityScreen({super.key});

  final Map<String, String> specialityImages = {
    'Neurology': 'assets/images/omar.png',
    'Anesthesiology': 'assets/images/omar.png',
    'Cardiology': 'assets/images/omar.png',
    'General': 'assets/images/omar.png',
    'Endocrinology': "assets/images/omar.png",
    'Dermatology': 'assets/images/omar.png',
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecialityCubit()..fetchSpecialities(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Doctor Speciality'),
          centerTitle: true,
        ),
        body: BlocBuilder<SpecialityCubit, SpecialityState>(
          builder: (context, state) {
            if (state is SpecialityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SpecialityError) {
              return Center(child: Text(state.error));
            } else if (state is SpecialitySuccess) {
              final cubit = SpecialityCubit.get(context);
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.12,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: cubit.specialities.length,
                itemBuilder: (context, index) {
                  final speciality = cubit.specialities[index];
                  final image = specialityImages[speciality.name] ??
                      'assets/images/default.png';

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          speciality.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
