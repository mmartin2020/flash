import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;
  final phonecontroller = TextEditingController();
  GlobalKey<FormFieldState> formkey = GlobalKey();

  Future<Map<String, dynamic>?> getUser() async {
    User? user = _auth.currentUser;
    try {
      Map<String, dynamic>? listaUser = await firebaseFireStore
          .collection('Users')
          .doc(user?.uid)
          .get()
          .then((data) => data.data());

      return listaUser;
    } catch (e) {
      return null;
    }
  }

  void updatePhoneNumber(String number) async {
    User? user = _auth.currentUser;

    try {
      await firebaseFireStore
          .collection('Users')
          .doc(user?.uid)
          .update({'phone': '$number'});
      Get.snackbar('Actualizado', '',
          backgroundColor: Colors.black,
          colorText: Colors.white,
          icon: Icon(Icons.verified_user, color: Colors.green));
      update();
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }
}
