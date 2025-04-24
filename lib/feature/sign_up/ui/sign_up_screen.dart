import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/extentions.dart';
import 'package:graduate_project/core/healpers/spacing.dart';
import 'package:graduate_project/core/routing/routes.dart';
import 'package:graduate_project/core/theming/colors.dart';
import 'package:graduate_project/core/theming/font_weight_helper.dart';
import 'package:graduate_project/feature/login/ui/login_screen.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_state.dart';

import '../logic/sign_up_cubit.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  final namecontrol = TextEditingController();
  final emailcontrol = TextEditingController();
  final phonecontrol = TextEditingController();
  final passcontrol = TextEditingController();
  final fromkey = GlobalKey<FormState>();
  bool isloding = false;

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is SignUpFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: fromkey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  verticalSpace(80),
                  const Text(
                    'sign Up',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeightHelper.bold,
                        color: ColorsManager.mainBlue),
                  ),
                  verticalSpace(20),
                  _textfield(hint: 'username', controller: namecontrol),
                  verticalSpace(20),
                  _textfield(hint: 'email', controller: emailcontrol),
                  verticalSpace(20),
                  _textfield(hint: 'phone', controller: phonecontrol),
                  verticalSpace(20),
                  _textfield(
                      hint: 'passWord', controller: passcontrol, isSecur: true),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (fromkey.currentState!.validate()) {
                              BlocProvider.of<SignupCubit>(context).register(
                                  name: namecontrol.text,
                                  email: emailcontrol.text,
                                  phone: phonecontrol.text,
                                  pass: passcontrol.text);
                            }
                          },
                          child: state is SignUpLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Register',
                                )),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'already have an acounnt',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushReplacementNamed(Routes.loginScreen);
                      },
                      child: const Text(
                        'login',
                        style: TextStyle(color: Colors.purple),
                      ),
                    )
                  ])
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textfield(
      {bool? isSecur,
      required String hint,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (data) {
        if (controller.text.isEmpty) {
          return '$hint must not be empty';
        } else {
          return null;
        }
      },
      obscureText: isSecur ?? false,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
