
import 'package:flutter/material.dart';

class Offer extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sentiment_very_dissatisfied,size: 200.0,color: Colors.grey,),
            Text('Upss! aun no tiene nada agregado en este espacio')
          ],
        ),),
      ),
    );
  }
}