import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: GestureDetector(
                    onTap: () {
                      print('okkkk');
                      Get.toNamed('/home', arguments: 3);
                    },
                    child: Text('Cart')))));
  }
}
