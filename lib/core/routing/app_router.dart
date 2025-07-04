import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/routing/routes.dart';
import 'package:graduate_project/feature/doctor/doctorScreen.dart';
//import 'package:graduate_project/feature/home/home_screen.dart';
import 'package:graduate_project/feature/layout/layout.dart';
import 'package:graduate_project/feature/layout/logic/layoutCubit.dart';
import 'package:graduate_project/feature/login/ui/login_screen.dart';
import 'package:graduate_project/feature/onboarding/onboarding_screen.dart';
import 'package:graduate_project/feature/sign_up/ui/sign_up_screen.dart';

import '../../feature/login/logic/login_cubit.dart';
import '../../feature/sign_up/logic/sign_up_cubit.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    // final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupCubit(),
            child: SignupScreen(),
          ),
        );

      case Routes.layoutScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LayoutCubit(),
            child: const LayoutScreen(),
          ),
        );
      case Routes.doctorScreen:
        return MaterialPageRoute(
          builder: (_) => const DoctorScreen(),
        );

      default:
        return null;
    }
  }
}
