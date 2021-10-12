import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{


  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
GlobalKey<FormState> formkey = GlobalKey();

  void forgetpassword() async{

    try {
      await _auth.sendPasswordResetEmail(email: email.text);
      Get.snackbar('', 'Revisa tu email para cambiar tu contraseña');
      

    } catch (e) {
      Get.snackbar('Error', '$e');
    }
    
  }

}