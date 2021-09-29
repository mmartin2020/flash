import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final emailcontroller = TextEditingController();
  final passwdcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final passwordv = TextEditingController();
  final formk = GlobalKey<FormState>();
  final telcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Example code for registration.
  Future<void> register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwdcontroller.text,
    ))
        .user;
    if (user != null) {
      Future.delayed(
          Duration(seconds: 2),
          () => Get.snackbar(
              'Confirmación', 'la cuenta ${user.email} fue creado con exito',
              backgroundColor: Colors.deepOrange.withOpacity(0.3),
              colorText: Colors.black));
    } else {
      Future.delayed(
          Duration(seconds: 2),
          () => Get.snackbar('', 'Error en la creacion  de cuenta',
              backgroundColor: Colors.red, colorText: Colors.white));
    }
  }


 @override
  void dispose() {
    emailcontroller.dispose();
    passwdcontroller.dispose();
    telcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }


  get name => namecontroller;
  get password => passwdcontroller;
  get phone => telcontroller;
  get email => emailcontroller;
  get formkey => formk;
  get passwordverify => passwordv;

 
}
