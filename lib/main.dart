import 'package:flutter/material.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/core/healpers/shared.dart';
import 'package:graduate_project/core/routing/app_router.dart';
import 'package:graduate_project/doc_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.intialise();
  token = CashNetwork.get(key: 'token');
  // ignore: avoid_print
  print("****/////////////////////$token///////////////////////****");
  runApp(DocApp(
    appRouter: AppRouter(),
  ));
}
