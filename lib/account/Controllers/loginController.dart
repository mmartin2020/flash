import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static final _emailcontroller = TextEditingController();
  static final _passwdcontroller = TextEditingController();
  static final _formkey = GlobalKey<FormState>();
  static final _tokenController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Code to signin with email and password
  Future<void> signInWithEmailAndPassword() async {
    try {
      final user = (await _auth.signInWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passwdcontroller.text,
      ));
      Get.defaultDialog(
          content: RefreshProgressIndicator(),
          backgroundColor: Colors.transparent,
          title: '');
      Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed('/home');
      });
    } catch (e) {
      print('$e');
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

// Code to signin to Facebook

  Future<void> signInWithFacebook() async {
    try {
      final AuthCredential credential = FacebookAuthProvider.credential(
        _tokenController.text,
      );
      final user = (await _auth.signInWithCredential(credential)).user;
      Get.snackbar('', 'Signin succefully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          showProgressIndicator: true);
    } catch (e) {
      print('$e');
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          showProgressIndicator: true);
    }
  }

// Code to signin with google
  Future<void> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);

      final user = userCredential.user;

      Get.offAllNamed('/home');
    } catch (e) {
      print('$e');
      Get.snackbar('Error para iniciar sesion con Google', '$e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwdcontroller.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  get emailcontroller => _emailcontroller;
  get passwdcontroller => _passwdcontroller;
  get tokenController => _tokenController;
  get formkey => _formkey;
}
