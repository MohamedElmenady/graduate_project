import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduate_project/core/healpers/app_regex.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/core/healpers/extentions.dart';
import 'package:graduate_project/core/healpers/spacing.dart';
import 'package:graduate_project/core/routing/routes.dart';
import 'package:graduate_project/core/theming/styles.dart';
import 'package:graduate_project/core/widgets/app_text_form_field.dart';
import 'package:graduate_project/feature/login/logic/login_cubit.dart';
import 'package:graduate_project/feature/login/logic/login_state.dart';
import 'package:graduate_project/feature/login/ui/widgits/dont_have_account_text.dart';
import 'package:graduate_project/feature/login/ui/widgits/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  final fromkey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Form(
      key: fromkey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyles.font24BlueBold,
                  ),
                  verticalSpace(8),
                  Text(
                    'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                    style: TextStyles.font14GrayRegular,
                  ),
                  verticalSpace(36),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is SuccessLogin) {
                        context.pushReplacementNamed(userType == "User"
                            ? Routes.layoutScreen
                            : Routes.doctorScreen);
                      } else if (state is FailueirLogin) {
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
                      return Column(
                        children: [
                          AppTextFormField(
                            hintText: 'Email',
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !AppRegex.isEmailValid(value)) {
                                return 'Please enter a valid email';
                              }
                            },
                            controller: cubit.emailcontrol,
                          ),
                          verticalSpace(18),
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
                          verticalSpace(24),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyles.font13BlueRegular,
                            ),
                          ),
                          verticalSpace(40),
                          ElevatedButton(
                              onPressed: () {
                                if (fromkey.currentState!.validate()) {
                                  cubit.login(
                                      email: cubit.emailcontrol.text,
                                      pass: cubit.passcontrol.text);
                                }
                              },
                              child: state is LodingLogin
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Login',
                                    )),
                          verticalSpace(24),
                          verticalSpace(16),
                          const TermsAndConditionsText(),
                          verticalSpace(60),
                          const DontHaveAccountText(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
