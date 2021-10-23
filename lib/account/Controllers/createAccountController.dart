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


        // _auth.

    if (user != null) {
      Usermodels usermodel = Usermodels(
          email: user.email,
          name: namecontroller.text,
          phone: telcontroller.text,
          uid: user.uid);
      formk.currentState!.reset();
      final cartshopping =
          firebaseFireStore.collection('cartshopping').doc(user.uid);
      //shoppingcart

      cartshopping.set({
        "A01": [0, false],
        "A02": [0, false],
        "A03": [0, false],
        "A04": [0, false],
        "A05": [0, false],
        "A06": [0, false],
        "A07": [0, false],
        "A08": [0, false],
        "A09": [0, false],
        "A010": [0, false],
        "A011": [0, false],
        "A012": [0, false],
        "A013": [0, false],
        "A014": [0, false],
        "A015": [0, false],
        "A016": [0, false],
        "A017": [0, false],
        "A018": [0, false],
        "A019": [0, false],
        "A020": [0, false],
        "A021": [0, false],
        "A022": [0, false],
      });

//set user cloud firestore
      firebaseFireStore
          .collection('Users')
          .doc(user.uid)
          .set(usermodel.toMap());

      Future.delayed(
          Duration(seconds: 1),
          () => Get.snackbar(
              'Confirmación', 'la cuenta ${user.email} fue creado con exito',
              backgroundColor: Colors.grey[800],
              colorText: Colors.white,
              icon: Icon(Icons.verified_user, color: Colors.green)));
      Future.delayed(Duration(seconds: 2), () => _auth.signOut());
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
