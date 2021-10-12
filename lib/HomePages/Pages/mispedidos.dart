
import 'package:flutter/material.dart';

class Pedidos extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.production_quantity_limits_outlined,size: 200.0,color: Colors.grey,),
            Text('Upss! aun no tiene nada agregado en este espacio')
          ],
        ),),
      ),
    );
  }
}