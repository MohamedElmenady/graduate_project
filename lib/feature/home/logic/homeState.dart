import '../../services/data/serviceModel.dart';
import '../data/doctor.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<SpecialityModel> specialities;
  final List<Doctor> doctors;

  HomeLoaded({required this.specialities, required this.doctors});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
