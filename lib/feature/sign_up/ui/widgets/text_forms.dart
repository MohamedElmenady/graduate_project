import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/app_regex.dart';
import 'package:graduate_project/core/healpers/spacing.dart';
import 'package:graduate_project/core/widgets/app_text_form_field.dart';
import 'package:graduate_project/feature/sign_up/logic/sign_up_cubit.dart';

class TextForms extends StatelessWidget {
  const TextForms({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SignupCubit>(context);
    return Column(children: [
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
          if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
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
            cubit.isObscureText ? Icons.visibility_off : Icons.visibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid password';
          }
        },
      ),
    ]);
  }
}
