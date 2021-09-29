import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
              child: Row(
                children: [
                  (Icon(
                    Icons.account_circle_sharp,
                    size: 80.0,
                  )),
                  Column(
                    children: [
                      Text(
                        'Janita Perez ',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        'Email: jperez@gmail.com',
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
                                decoration: TextDecoration.underline,
                              ))),
                    ],
                  )
                ],
              ),
            ),
          )),
          ListTile(
            title: Text('Mis favoritos'),
            leading: Icon(Icons.favorite),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          Divider(),
          ListTile(
            title: Text('Mis Pedidos'),
            leading: Icon(Icons.shopping_cart_outlined),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          Divider(),
          ListTile(
            title: Text('Soy repartidor'),
            leading: Icon(Icons.delivery_dining_rounded),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          Divider(),
          ListTile(
            title: Text('Soy negociante'),
            leading: Icon(Icons.group),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          Divider(),
          ListTile(
            title: Text('Soporte'),
            leading: Icon(Icons.live_help_outlined),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          Divider(),
          ListTile(
            title: Text('Terminos y condiciones'),
            leading: Icon(Icons.info),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          Divider(),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Future.delayed(Duration(seconds: 4), () {
                  Get.defaultDialog(
                    backgroundColor: null,
                    content: Container(
                      child: RefreshProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.black,
                      ),
                    ),
                  );
                  Get.offAllNamed('/login');
                });
              });
            },
            title: Text('Cerrar sessión'),
            leading: Icon(
              Icons.delete_rounded,
            ),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          Divider(),
        ],
      ),
    );
  }
}
