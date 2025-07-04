import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/home/data/apiService.dart';
import 'package:graduate_project/feature/home/logic/homeState.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit(this.apiService) : super(HomeInitial());

  void fetchData() async {
    emit(HomeLoading());
    try {
      name = await apiService.getName();
      final specialities = await apiService.getSpecialities();
      final doctors = await apiService.getRecommendedDoctors();
      emit(HomeLoaded(specialities: specialities, doctors: doctors));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
