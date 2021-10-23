import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

//Code to signin with email and password
  Future<void> signInWithEmailAndPassword() async {
    try {
      (await _auth.signInWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passwdcontroller.text,
      ));
      Get.defaultDialog(
          radius: 0.0,
          content: RefreshProgressIndicator(),
          backgroundColor: Colors.transparent,
          title: '');
      Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed('/home');
      });
    } catch (e) {
      print('$e');
      Get.snackbar('Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(Icons.warning, color: Colors.white));
    }
  }

// Code to signin to Facebook

  // Future<void> signInWithFacebook() async {
  //   try {
  //     final AuthCredential credential = FacebookAuthProvider.credential(
  //       _tokenController.text,
  //     );
  //     (await _auth.signInWithCredential(credential)).user;
  //     Get.snackbar('', 'Signin succefully',
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.black,
  //         showProgressIndicator: true);
  //   } catch (e) {
  //     print('$e');
  //     Get.snackbar('Error', '$e',
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.black,
  //         showProgressIndicator: true);
  //   }
  // }

// Code to signin with google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential usercredential =
          await _auth.signInWithCredential(googleAuthCredential);
      firebaseFireStore.collection('Users').doc(_auth.currentUser!.uid).set({
        'name': usercredential.user?.displayName,
        'email': usercredential.user?.email,
        'phone': usercredential.user?.phoneNumber,
        'uid': usercredential.user?.uid,
      });
      await firebaseFireStore
          .collection('cartshopping')
          .doc(usercredential.user?.uid)
          .snapshots()
          .listen((event) {
        if (!event.exists)
          firebaseFireStore
              .collection('cartshopping')
              .doc(usercredential.user?.uid)
              .set({
            'A01': [0, false],
            'A02': [0, false],
            'A03': [0, false],
            'A04': [0, false],
            'A05': [0, false],
            'A06': [0, false],
            'A07': [0, false],
            'A08': [0, false],
            'A09': [0, false],
            'A010': [0, false],
            'A011': [0, false],
            'A012': [0, false],
            'A013': [0, false],
            'A014': [0, false],
            'A015': [0, false],
            'A016': [0, false],
            'A017': [0, false],
            'A018': [0, false],
            'A019': [0, false],
            'A020': [0, false],
            'A021': [0, false],
            'A022': [0, false],
            'A023': [0, false],
            'A024': [0, false],
            'A025': [0, false],
          });

        ;
      });

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Falló en el inicio de sesion con Google', '$e',
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
