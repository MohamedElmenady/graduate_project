import 'package:flutter/material.dart';
import 'package:graduate_project/core/healpers/shared.dart';
import 'package:graduate_project/core/routing/app_router.dart';
import 'package:graduate_project/doc_app.dart';

void main() async {
  //int index = 0;
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.intialise();
  runApp(DocApp(
    appRouter: AppRouter(),
  ));
}
