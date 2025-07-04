abstract class SpecialityState {}

class SpecialityInitial extends SpecialityState {}

class SpecialityLoading extends SpecialityState {}

class SpecialitySuccess extends SpecialityState {}

class SpecialityError extends SpecialityState {
  final String error;
  SpecialityError(this.error);
}
