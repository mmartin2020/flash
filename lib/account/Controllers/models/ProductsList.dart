import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductsList extends GetxController {
  var counter = 0.obs;
  var favorito = true.obs;
  User? user = FirebaseAuth.instance.currentUser;
  final instance = FirebaseFirestore.instance;

  void InitialState(RxInt id) {
    counter = id;
  }

  void increment(String idproducts,image,titulo) {
    instance.collection('cartshopping').doc(user!.uid).get().then((value) {
      List lista = value.data()![idproducts].toList();
      int ls = lista[0];
      ls++;
      instance.collection('cartshopping').doc(user!.uid).update({
        idproducts: [ls, lista[1]]
      });

      counter++;

      update();
    });
  }

  void discrement(String idproducts) {
    instance.collection('cartshopping').doc(user!.uid).get().then((value) {
      List lista = value.data()![idproducts].toList();
      int ls = lista[0];

      if (ls > 0) {
        ls--;
        instance.collection('cartshopping').doc(user!.uid).update({
          idproducts: [ls, lista[1]]
        });

        counter--;

        update();
      }
    });
  }

  void favorite(String idproducts) {
    instance.collection('cartshopping').doc(user!.uid).get().then((value) {
      List lista = value.data()![idproducts].toList();
      int ls = lista[0];
      bool favorite = lista[1];

      instance.collection('cartshopping').doc(user!.uid).update({
        idproducts: [ls, !favorite]
      });
    });
  }
}
