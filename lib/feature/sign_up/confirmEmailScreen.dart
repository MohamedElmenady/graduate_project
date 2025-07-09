import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/extentions.dart';
import 'package:graduate_project/core/routing/routes.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_cubit.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmEmailScreen extends StatelessWidget {
  ConfirmEmailScreen({super.key, required this.email});
  final String email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final codeController = context.read<SignupCubit>().codeController;
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Email')),
      body: BlocConsumer<SignupCubit, SignUpState>(
        listener: (context, state) {
          if (state is ConfirmEmailSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email confirmed")),
            );
            context.pushReplacementNamed(Routes.loginScreen);
            // Navigate or do something after success
          } else if (state is ConfirmEmailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enter the 6-digit code sent to your email",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    controller: codeController,
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Code is required';
                      }
                      if (value.length != 6) {
                        return 'Code must be 6 digits';
                      }
                      return null;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is ConfirmEmailLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignupCubit>().confirmEmail(
                                  code: codeController.text.trim(),
                                  email: email);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.blue,
                    ),
                    child: state is ConfirmEmailLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Submit"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
