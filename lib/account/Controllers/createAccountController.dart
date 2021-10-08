import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/models/UserModels.dart';

class CreateAccountController extends GetxController {
  final emailcontroller = TextEditingController();
  final passwdcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final confirmcontroller = TextEditingController();
  final formk = GlobalKey<FormState>();
  final telcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  //  code for registration.
  Future<void> register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwdcontroller.text,
    ))
        .user;

    if (user != null) {
      Usermodels usermodel = Usermodels(
          email: user.email,
          name: namecontroller.text,
          phone: telcontroller.text,
          uid: user.uid);

//set user cloud firestore
      firebaseFireStore
          .collection('Users')
          .doc(user.uid)
          .set(usermodel.toMap())
          .then((value) {
        formk.currentState?.reset();
        Future.delayed(
            Duration(seconds: 1),
            () => Get.snackbar(
                'Confirmación', 'la cuenta ${user.email} fue creado con exito',
                backgroundColor: Colors.black,
                colorText: Colors.white,
                icon: Icon(Icons.verified_user, color: Colors.green)));
      });
    } else {
      Future.delayed(
          Duration(seconds: 1),
          () => Get.snackbar('', 'Error en la creación  de cuenta',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              icon: Icon(Icons.warning, color: Colors.white)));
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
  get passwordverify => confirmcontroller;
}
