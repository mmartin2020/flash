import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/models/productModels.dart';

class Favorite extends StatelessWidget {
  final products = Get.put(Products());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sentiment_very_dissatisfied,
                size: 200.0,
                color: Colors.grey,
              ),
              Text('Upss! aun no tiene nada agregado en este espacio'),
              OutlinedButton(
                  onPressed: () {
                
                  },
                  child: Text('up dada to firebase'))
            ],
          ),
        ),
      ),
    );
  }
}
