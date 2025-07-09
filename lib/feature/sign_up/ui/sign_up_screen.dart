import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/app_regex.dart';
import 'package:graduate_project/core/healpers/extentions.dart';
import 'package:graduate_project/core/healpers/spacing.dart';
import 'package:graduate_project/core/routing/routes.dart';
import 'package:graduate_project/core/theming/colors.dart';
import 'package:graduate_project/core/theming/font_weight_helper.dart';
import 'package:graduate_project/core/widgets/app_text_form_field.dart';
import 'package:graduate_project/feature/sign_up/confirmEmailScreen.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_state.dart';

import '../logic/sign_up_cubit.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  final fromkey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignupCubit>(context);
    return BlocConsumer<SignupCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<SignupCubit>(),
                child: ConfirmEmailScreen(email: cubit.emailcontrol.text),
              ),
            ),
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
                  // ignore: prefer_const_constructors
                  AppTextFormField(
                    hintText: 'username',
                    controller: cubit.namecontrol,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid username';
                      }
                    },
                  ),
                  verticalSpace(20),
                  AppTextFormField(
                    hintText: 'email',
                    controller: cubit.emailcontrol,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !AppRegex.isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }
                    },
                  ),
                  verticalSpace(20),
                  AppTextFormField(
                    hintText: 'phone',
                    controller: cubit.phonecontrol,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid phone number';
                      }
                    },
                  ),
                  verticalSpace(20),
                  AppTextFormField(
                    controller: cubit.passcontrol,
                    hintText: 'Password',
                    isObscureText: cubit.isObscureText,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        cubit.vision();
                      },
                      child: Icon(
                        cubit.isObscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                    },
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (fromkey.currentState!.validate()) {
                              cubit.register(
                                  name: cubit.namecontrol.text.trim(),
                                  email: cubit.emailcontrol.text.trim(),
                                  phone: cubit.phonecontrol.text.trim(),
                                  pass: cubit.passcontrol.text.trim());
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
}
