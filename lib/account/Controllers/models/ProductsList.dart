import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductsList extends GetxController {
  var counter = 0.obs;
  var favorito = true.obs;
  final instance = FirebaseFirestore
  .instance.collection('cartshopping')
  .doc(FirebaseAuth.instance.currentUser!.uid);
  var radio = 0.obs;

 
  void InitialState(RxInt id) {
    counter = id;
  }

  void increment(String idproducts, image, titulo,price) {
    instance.get().then((value) {
      List lista = value.data()![idproducts].toList();
      int ls = lista[0];
      ls++;
      instance.update({
        idproducts: [ls, lista[1], titulo,price, image]
      });

      counter++;

      update();
    });
  }

  void discrement(String idproducts, image, titulo,price) {
    instance.get().then((value) {
      List lista = value.data()![idproducts].toList();
      int ls = lista[0];

      if (ls > 0) {
        ls--;
        instance.update({
          idproducts: [ls, lista[1], titulo,price, image]
        });

        counter--;

        update();
      }
    });
  }

  void favorite(String idproducts,titulo, image,price) {
    instance.get().then((value) {
      List lista = value.data()![idproducts].toList();
      int ls = lista[0];
      bool favorite = lista[1];

      instance.update({
        idproducts: [ls, !favorite,titulo,price, image]
      });
    });
  }

 String numberFormat(x) {
    List<String> parts = x.toString().split('.');
    RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

    parts[0] = parts[0].replaceAll(re, '.');
    if (parts.length == 1) {
      parts.add('00');
    } else {
      parts[1] = parts[1].padRight(2, '0').substring(0, 2);
    }
    return parts.join(',');
  }


void cart_delete(id,fav,title,price,image){
  instance.update({
                        id: [0, fav, title, price, image]
                      });
                      update();
}

void changeRadioState(v){
 radio = v;
 update();
}


}
