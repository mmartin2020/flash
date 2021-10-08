import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/Data/textdata.dart';
import 'package:log/account/Controllers/adminController.dart';

import 'explore.dart';
import 'offer.dart';
import 'shop.dart';
import 'shopping_cart.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeViewState();
}

class _HomeViewState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final User? user = FirebaseAuth.instance.currentUser;
  final admincontroller = Get.put(AdminController());
  int _currentIndex = 0;
  _indexCallBack(int i) {
    i == 4
        ? _scaffoldKey.currentState?.openDrawer()
        : setState(() {
            _currentIndex = i;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder(
                    future: admincontroller.getUser(),
                    builder: (BuildContext context, AsyncSnapshot snapshots) {
                      if (snapshots.connectionState == ConnectionState.done) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            user!.photoURL == '' || user?.photoURL == null
                                ? Icon(Icons.account_circle_sharp,
                                    size: 80.0, color: Colors.grey)
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage('${user?.photoURL}'),
                                  ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${user?.displayName == '' || user?.displayName == null ? snapshots.data['name'] : user?.displayName}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                Spacer(),
                                Text(
                                  user?.email ?? '',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                Spacer(),
                                telWidget(user, snapshots.data),
                                Spacer(),
                              ],
                            )
                          ],
                        );
                      }
                      if (snapshots.connectionState == ConnectionState.waiting)
                        return Center(
                          child: Container(
                            child: RefreshProgressIndicator(),
                          ),
                        );

                      return Center(
                        child: Container(
                          child: RefreshProgressIndicator(),
                        ),
                      );
                    }),
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
            _listTile('Cerrar sessión', Icons.exit_to_app_outlined, 'c'),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Get.defaultDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Cancelar')),
                            TextButton(
                                onPressed: () {
                                  user?.reload();
                                  user?.delete();
                                  Get.offNamed('/login');
                                },
                                child: Text('Confirmar'))
                          ],
                          content: Text(
                              '¿Estás seguro de querer eliminar la cuenta?'),
                          backgroundColor: Colors.white,
                          title: 'Eliminar cuenta');
                    },
                    child: Text(
                      'Eliminar la cuenta',
                      style: TextStyle(color: Colors.blueGrey),
                    )),
                AbsorbPointer(
                  absorbing: disableEnableButton(),
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                            color: disableEnableButton()
                                ? Colors.grey
                                : Colors.blueGrey),
                      )),
                )
              ],
            )
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Explore(),
          Shop(),
          ShoppingCart(),
          Offer(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(size: 20.0),
        currentIndex: _currentIndex,
        onTap: _indexCallBack,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme:
            IconThemeData(color: Colors.blueGrey.withOpacity(0.5)),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: TextData.TEXT_LABEL_INICIO,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: TextData.TEXT_LABEL_SHOP,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            label: TextData.TEXT_LABEL_CARRITO,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: TextData.TEXT_LABEL_OFFER,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: TextData.TEXT_LABEL_PROFIL),
        ],
      ),
    );
  }

  String getProvider() {
    switch (user?.providerData.elementAt(0).providerId) {
      case 'google.com':
        return 'google';

      case 'facebook.com':
        return 'facebook';

      default:
        return 'empty';
    }
  }

  bool disableEnableButton() {
    if (getProvider() == 'empty') {
      return false;
    } else {
      return true;
    }
  }

  Widget telWidget(User? user, map) {
    String variable = '';
    if (getProvider() == 'google') {
      variable = 'Tel: ${user?.phoneNumber == '' ? '-' : user?.phoneNumber}';
    } else {
      variable = 'Tel: ${map['phone'] == '' ? '' : map['phone']}';
    }
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(Card(
            child: Column(children: [
          Text('Modificar mi número de teléfono'),
          TextFormField(
            decoration: InputDecoration(hintText: variable),
            keyboardType: TextInputType.phone,
            controller: admincontroller.phonecontroller,
          )
        ])));
      },
      child: Row(
        children: [
          Text(variable,
              style: TextStyle(
                fontSize: 16.0,
              )),
          Icon(
            Icons.edit,
            size: 16.0,
          ),
        ],
      ),
    );
  }

  Widget _listTile(String title, IconData icon, String onTap) {
    return ListTile(
      title: Text(title,
          style:
              TextStyle(color: onTap == 'e' ? Colors.grey : Colors.blueGrey)),
      leading: onTap == 'e' ? null : Icon(icon, color: Colors.blueGrey),
      trailing: onTap == 'e'
          ? null
          : Icon(Icons.arrow_forward_ios_outlined, color: Colors.blueGrey),
      selectedTileColor: Colors.deepOrange.withOpacity(0.5),
      onTap: () {
        switch (onTap) {
          case 'f':
            // Get.toNamed('/misfavoritos');
           
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
