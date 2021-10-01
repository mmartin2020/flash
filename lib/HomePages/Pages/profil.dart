import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Container(
      child: ListView(
        children: [
          DrawerHeader(
              child: Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  user!.photoURL == '' || user.photoURL == null
                      ? Icon(Icons.account_circle_sharp,
                          size: 80.0, color: Colors.grey)
                      : Image(
                          width: 80.0,
                          height: 80.0,
                          image: NetworkImage('${user.photoURL}'),
                        ),
                  Column(
                    children: [
                      Text(
                        user.displayName ?? '',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        user.email ?? '',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed('/admincuenta');
                          },
                          child: Text('Administrar mi cuenta',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                                decoration: TextDecoration.underline,
                              ))),
                    ],
                  )
                ],
              ),
            ),
          )),
          _listTile('Mis favoritos', Icons.favorite, 'f'),
          Divider(),
          _listTile('Mis Pedidos', Icons.shopping_cart_outlined, 'p'),
          Divider(),
          _listTile('Soy repartidor', Icons.delivery_dining_rounded, 'r'),
          Divider(),
          _listTile('Soy negociante', Icons.group, 'n'),
          Divider(),
          _listTile('Soporte', Icons.live_help_outlined, 's'),
          Divider(),
          _listTile('Terminos y condiciones', Icons.info, 't'),
          Divider(),
          _listTile('Cerrar sessión', Icons.delete_rounded, 'c'),
          Divider(),
        ],
      ),
    );
  }

  Widget _listTile(String title, IconData icon, String onTap) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.blueGrey)),
      leading: Icon(icon, color: Colors.blueGrey),
      trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blueGrey),
      selectedTileColor: Colors.deepOrange.withOpacity(0.5),
      onTap: () {
        switch (onTap) {
          case 'f':
            Get.toNamed('/misfavoritos');
            break;
          case 'p':
            Get.toNamed('/misfavoritos');
            break;
          case 'r':
            Get.toNamed('/misfavoritos');
            break;
          case 'n':
            Get.toNamed('/misfavoritos');
            break;
          case 's':
            Get.toNamed('/misfavoritos');
            break;
          case 't':
            Get.toNamed('/misfavoritos');
            break;
          case 'c':
            FirebaseAuth.instance.signOut().then((value) {
              Get.defaultDialog(
                  content: RefreshProgressIndicator(),
                  backgroundColor: Colors.transparent.withOpacity(0.0),
                  title: '');
              Future.delayed(Duration(seconds: 2), () {
                Get.offAllNamed('/login');
              });
            });
            break;
        }
      },
    );
  }
}
