abstract class LoginState {}

class InitialLogin extends LoginState {}

class LodingLogin extends LoginState {}

class SuccessLogin extends LoginState {}

class FailueirLogin extends LoginState {
  final String message;

  FailueirLogin({required this.message});
}

class SuccessState extends LoginState {}
