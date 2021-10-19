import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:log/pageroutes.dart';

main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9000);
  final _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;

  runApp(GetMaterialApp(
    title: 'Flashliver',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.deepOrange,
      inputDecorationTheme: InputDecorationTheme(
        focusColor: Color(0xFFDB5C00),
      ),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: user == null ? '/initialpage' : '/home',
    getPages: routes,
  ));
}
