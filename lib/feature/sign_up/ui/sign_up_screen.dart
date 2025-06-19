import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/extentions.dart';
import 'package:graduate_project/core/healpers/spacing.dart';
import 'package:graduate_project/core/routing/routes.dart';
import 'package:graduate_project/core/theming/colors.dart';
import 'package:graduate_project/core/theming/font_weight_helper.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_state.dart';
import 'package:graduate_project/feature/sign_up/ui/widgets/text_forms.dart';

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
          context.pushReplacementNamed(Routes.loginScreen);
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
                  TextForms(),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (fromkey.currentState!.validate()) {
                              cubit.register(
                                  name: cubit.namecontrol.text,
                                  email: cubit.emailcontrol.text,
                                  phone: cubit.phonecontrol.text,
                                  pass: cubit.passcontrol.text);
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
