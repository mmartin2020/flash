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
     
      final cartshopping =
          firebaseFireStore.collection('cartshopping').doc(user.uid);
      //shoppingcart

      cartshopping.set({
        "A01": [0, false,'name','precio','image'],
        "A02": [0, false,'name','precio','image'],
        "A03": [0, false,'name','precio','image'],
        "A04": [0, false,'name','precio','image'],
        "A05": [0, false,'name','precio','image'],
        "A06": [0, false,'name','precio','image'],
        "A07": [0, false,'name','precio','image'],
        "A08": [0, false,'name','precio','image'],
        "A09": [0, false,'name','precio','image'],
        "A010": [0, false,'name','precio','image'],
        "A011": [0, false,'name','precio','image'],
        "A012": [0, false,'name','precio','image'],
        "A013": [0, false,'name','precio','image'],
        "A014": [0, false,'name','precio','image'],
        "A015": [0, false,'name','precio','image'],
        "A016": [0, false,'name','precio','image'],
        "A017": [0, false,'name','precio','image'],
        "A018": [0, false,'name','precio','image'],
        "A019": [0, false,'name','precio','image'],
        "A020": [0, false,'name','precio','image'],
        "A021": [0, false,'name','precio','image'],
        "A022": [0, false,'name','precio','image'],
      
      });
      formk.currentState!.reset();

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
