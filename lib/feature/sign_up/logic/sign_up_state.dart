abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure({required this.message});
}

class SuccessState extends SignUpState {}

class ConfirmEmailLoading extends SignUpState {}

class ConfirmEmailSuccess extends SignUpState {}

class ConfirmEmailError extends SignUpState {
  final String message;
  ConfirmEmailError(this.message);
}
