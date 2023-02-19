import 'package:app_despesas/views/cost_page.dart';
import 'package:app_despesas/views/home_page.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(
        name: '/home',
        page: () => HomePage(),
      ),
      GetPage(
        name: '/costPage',
        page: () => CostPage(),
      ),
    ],
    theme: ThemeData(hintColor: Colors.black),
    debugShowCheckedModeBanner: false,
  ));
}