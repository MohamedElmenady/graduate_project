import 'package:graduate_project/feature/profile/data/userModel.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class EditProfileInitial extends ProfileState {}

class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {}

class EditProfileError extends ProfileState {
  final String message;

  EditProfileError(this.message);
}
