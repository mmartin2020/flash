import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCart extends StatelessWidget {
  final productos = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: StreamBuilder<List<ListTile>>(
                stream: sendProducts([]),
                builder: (context, snapshot) {
                  return ListView(
                    children: snapshot.data!.toList(),
                  );
                })));
  }

  Stream<List<ListTile>> sendProducts(lista) {
    return lista;
  }
}
