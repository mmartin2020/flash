import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Admincuenta extends StatefulWidget {
  @override
  State<Admincuenta> createState() => AdmincuentaState();
}

class AdmincuentaState extends State<Admincuenta> {
  @override
  Widget build(BuildContext context) {
    final value = true;
    final valor = true;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: false,
            activeColor: Colors.black,
            onChanged: (value) {
              Get.changeTheme(ThemeData.dark());
            },
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed('/home');
            },
            icon: Icon(Icons.close)),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Card(
                child: Stack(children: [
                  Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: Column(
                        children: [
                          Text(value ? 'Oscuro' : 'light'),
                          Switch(
                            value: value,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                value = !value;
                                value
                                    ? Get.changeTheme(ThemeData.dark())
                                    : Get.changeTheme(ThemeData.light());
                              });
                            },
                          ),
                        ],
                      )),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 200,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Nombre: Juanita Perez'),
                          Text('jperez@gmail.com'),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ]),
              ),
              // mis direcciones
              ListTile(
                  onTap: () {
                    Get.dialog(
                      Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 100.0, horizontal: 20.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading:
                                      Icon(Icons.add_location_alt_outlined),
                                  title: Text('Mis Direcciones'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RadioListTile(
                                            value: true,
                                            groupValue: 1,
                                            onChanged: (v) {},
                                            title:
                                                Text('Americo vespucio #5767')),
                                        RadioListTile(
                                            value: false,
                                            groupValue: 2,
                                            onChanged: (v) {},
                                            title: Text('Av Portales #3045')),
                                        SizedBox(height: 20.0),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(CupertinoIcons.add),
                                              Text(
                                                  'Agregar una nueva dirección')
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                          )),
                    );
                  },
                  dense: true,
                  focusColor: Colors.grey[400],
                  selectedTileColor: Colors.grey,
                  title: Text('Mis Direcciones'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(),
              ),

              //modificar nombre
              ListTile(
                  dense: true,
                  focusColor: Colors.grey[400],
                  selectedTileColor: Colors.grey,
                  onTap: () {
                    Get.dialog(Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 200.0, horizontal: 20.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Modificación de nombre',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: _inputT(Icon(Icons.person, size: 13.0),
                                    'Ingrese el nuevo nombre...', context,false),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor)),
                                child: Text('Acceptar'),
                                onPressed: () {
                                  Get.snackbar('Notificación',
                                      'Su nombre fue modificado exitosamente');
                                },
                              ),
                            ],
                          ),
                        )));
                  },
                  title: Text('Modificar mi nombre'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                  )),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(),
              ),

              // Modicficar contraseña
              //modificar nombre
              ListTile(
                  dense: true,
                  focusColor: Colors.grey[400],
                  selectedTileColor: Colors.grey,
                  onTap: () {
                    Get.dialog(Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 200.0, horizontal: 20.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Modificación de nombre',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: _inputT(
                                    Icon(Icons.lock, size: 13.0),
                                    'Ingrese antigua contraseña...',
                                    context,
                                    true),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                child: _inputT(
                                    Icon(Icons.lock, size: 13.0),
                                    'Ingrese contraseña nueva...',
                                    context,
                                    true),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor)),
                                child: Text('Acceptar'),
                                onPressed: () {
                                  Get.snackbar('Notificación',
                                      'Su contraseña fue modificado con éxito');
                                },
                              ),
                            ],
                          ),
                        )));
                  },
                  title: Text('Modificar mi contraseña'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                  )),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(),
              ),

              // Eliminar cuenta
              ListTile(
                  onTap: () {
                    Get.dialog(
                      Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 100.0, horizontal: 20.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.info),
                                  title: Text(
                                      'Una vez que se encuentra eliminada su cuenta no podrá volver a inicial sesión con la misma cuenta'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '¿Por qué quiere eliminar su cuenta?'),
                                      CheckboxListTile(
                                        value: valor,
                                        onChanged: (valor) {
                                          setState(() {
                                            if (valor == true) {
                                              valor = false;
                                            } else {
                                              valor = true;
                                            }
                                          });
                                        },
                                        title:
                                            Text('No me gustó la aplicación'),
                                      ),
                                      CheckboxListTile(
                                        value: valor,
                                        onChanged: (valor) {
                                          setState(() {
                                           if (valor == true) {
                                              valor = false;
                                            } else {
                                              valor = true;
                                            }
                                          });
                                        },
                                        title:
                                            Text(' La aplicación no funciona'),
                                      ),
                                      TextField(
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            hintText: 'Otra / sugerencias...'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor)),
                                  child: Text('Confirmar y continuar'),
                                  onPressed: () {
                                    Get.snackbar('Notificación',
                                        'Su cuenta fue eliminado con  éxito');
                                    Future.delayed(Duration(seconds: 1));
                                    Get.offAllNamed('/login');
                                  },
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                  dense: true,
                  focusColor: Colors.grey[400],
                  selectedTileColor: Colors.grey,
                  title: Text('Eliminar mi cuenta'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputT(Icon icon, String text, BuildContext context, bool obscur) {
    return Container(
      child: TextField(
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 13.0, decoration: TextDecoration.none),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.grey,
          obscureText: obscur ,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(14),
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefix: icon,
              hintText: text,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ))),
    );
  }
}
