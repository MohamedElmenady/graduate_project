import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/profile/personal_info/data/userModel.dart';
import 'package:graduate_project/feature/profile/personal_info/logic/personInfoCubit.dart';
import 'package:graduate_project/feature/profile/personal_info/logic/stateCubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  //final emailController = TextEditingController();
  //final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    //emailController.dispose();
    //passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Personal information"),
          centerTitle: true,
          leading: const BackButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Profile updated successfully!")),
                );
              } else if (state is EditProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'assets/images/omar.png',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField('Name', nameController),
                  //_buildTextField('Email', emailController),
                  //_buildTextField("Password", passwordController,
                  // obscure: true),
                  _buildTextField("Phone", phoneController),
                  const SizedBox(height: 10),
                  const Text(
                    "When you set up your personal information settings,\nyou should take care to provide accurate information.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: state is EditProfileLoading
                        ? null
                        : () {
                            final user = EditModel(
                              name: nameController.text,
                              // email: emailController.text,
                              phone: phoneController.text,
                              // password: passwordController.text,
                            );
                            context
                                .read<EditProfileCubit>()
                                .updateProfile(user);
                          },
                    child: state is EditProfileLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Save",
                            style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {bool readOnly = false, bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF6F6F6),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
