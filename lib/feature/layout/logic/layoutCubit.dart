import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/event/eventScreen.dart';
import 'package:graduate_project/feature/home/home_screen.dart';
import 'package:graduate_project/feature/layout/logic/layoutState.dart';
import 'package:graduate_project/feature/profile/profileScreen.dart';
import 'package:graduate_project/feature/services/servicesScreen.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(IntialState());

  int indexCubit = 0;
  List<Widget> layoutScreen = [
    const HomeScreen(),
    SpecialityScreen(),
    const AppointmentsScreen(),
    const ProfileScreen()
  ];
  void getValue({required int index}) {
    indexCubit = index;
    emit(LayoutSuccess());
  }
}
