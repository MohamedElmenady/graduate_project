import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/theming/colors.dart';
import 'package:graduate_project/feature/layout/logic/layoutCubit.dart';
import 'package:graduate_project/feature/layout/logic/layoutState.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.indexCubit,
            onTap: (index) {
              cubit.getValue(index: index);
            },
            selectedItemColor: ColorsManager.mainBlue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medical_services), label: 'Services'),
              /* BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),*/
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
          body: cubit.layoutScreen[cubit.indexCubit],
        );
      },
    );
  }
}
